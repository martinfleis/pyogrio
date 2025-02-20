from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED

import pytest

from pyogrio import __gdal_version_string__, __version__, list_drivers


data_dir = Path(__file__).parent.resolve() / "fixtures"


def pytest_report_header(config):
    drivers = ", ".join(sorted(list(list_drivers(read=True).keys())))
    return (
        f"pyogrio {__version__}\n"
        f"GDAL {__gdal_version_string__}\n"
        f"Supported drivers: {drivers}"
    )


@pytest.fixture(scope="session")
def naturalearth_lowres():
    return data_dir / Path("naturalearth_lowres/naturalearth_lowres.shp")


@pytest.fixture
def naturalearth_lowres_vsi(tmp_path, naturalearth_lowres):
    """Wrap naturalearth_lowres as a zip file for vsi tests"""

    path = tmp_path / f"{naturalearth_lowres.name}.zip"
    with ZipFile(path, mode="w", compression=ZIP_DEFLATED, compresslevel=5) as out:
        # out.write(naturalearth_lowres, naturalearth_lowres.name)
        for ext in ["dbf", "prj", "shp", "shx"]:
            filename = f"{naturalearth_lowres.stem}.{ext}"
            out.write(naturalearth_lowres.parent / filename, filename)

    return f"/vsizip/{path}/{naturalearth_lowres.name}"


@pytest.fixture(scope="session")
def test_fgdb_vsi():
    return f"/vsizip/{data_dir}/test_fgdb.gdb.zip"

