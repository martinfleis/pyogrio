# Contains declarations against GDAL / OGR API
from libc.stdint cimport int64_t


cdef extern from "cpl_conv.h":
    ctypedef unsigned char GByte

    void*   CPLMalloc(size_t)
    void    CPLFree(void *ptr)

    const char* CPLGetConfigOption(const char* key, const char* value)
    void        CPLSetConfigOption(const char* key, const char* value)


cdef extern from "cpl_error.h":
    ctypedef enum CPLErr:
        CE_None
        CE_Debug
        CE_Warning
        CE_Failure
        CE_Fatal

    void            CPLErrorReset()
    int             CPLGetLastErrorNo()
    const char*    CPLGetLastErrorMsg()
    int             CPLGetLastErrorType()


cdef extern from "cpl_string.h":
    char**      CSLAddNameValue(char **list, const char *name, const char *value)
    char**      CSLSetNameValue(char **list, const char *name, const char *value)
    void        CSLDestroy(char **list)
    char**      CSLAddString(char **list, const char *string)


cdef extern from "ogr_core.h":
    ctypedef enum OGRErr:
        OGRERR_NONE  # success
        OGRERR_NOT_ENOUGH_DATA
        OGRERR_NOT_ENOUGH_MEMORY
        OGRERR_UNSUPPORTED_GEOMETRY_TYPE
        OGRERR_UNSUPPORTED_OPERATION
        OGRERR_CORRUPT_DATA
        OGRERR_FAILURE
        OGRERR_UNSUPPORTED_SRS
        OGRERR_INVALID_HANDLE
        OGRERR_NON_EXISTING_FEATURE

    ctypedef enum OGRwkbGeometryType:
        wkbUnknown
        wkbPoint
        wkbLineString
        wkbPolygon
        wkbMultiPoint
        wkbMultiLineString
        wkbMultiPolygon
        wkbGeometryCollection
        wkbCircularString
        wkbCompoundCurve
        wkbCurvePolygon
        wkbMultiCurve
        wkbMultiSurface
        wkbCurve
        wkbSurface
        wkbPolyhedralSurface
        wkbTIN
        wkbTriangle
        wkbNone
        wkbLinearRing
        wkbCircularStringZ
        wkbCompoundCurveZ
        wkbCurvePolygonZ
        wkbMultiCurveZ
        wkbMultiSurfaceZ
        wkbCurveZ
        wkbSurfaceZ
        wkbPolyhedralSurfaceZ
        wkbTINZ
        wkbTriangleZ
        wkbPointM
        wkbLineStringM
        wkbPolygonM
        wkbMultiPointM
        wkbMultiLineStringM
        wkbMultiPolygonM
        wkbGeometryCollectionM
        wkbCircularStringM
        wkbCompoundCurveM
        wkbCurvePolygonM
        wkbMultiCurveM
        wkbMultiSurfaceM
        wkbCurveM
        wkbSurfaceM
        wkbPolyhedralSurfaceM
        wkbTINM
        wkbTriangleM
        wkbPointZM
        wkbLineStringZM
        wkbPolygonZM
        wkbMultiPointZM
        wkbMultiLineStringZM
        wkbMultiPolygonZM
        wkbGeometryCollectionZM
        wkbCircularStringZM
        wkbCompoundCurveZM
        wkbCurvePolygonZM
        wkbMultiCurveZM
        wkbMultiSurfaceZM
        wkbCurveZM
        wkbSurfaceZM
        wkbPolyhedralSurfaceZM
        wkbTINZM
        wkbTriangleZM
        wkbPoint25D
        wkbLineString25D
        wkbPolygon25D
        wkbMultiPoint25D
        wkbMultiLineString25D
        wkbMultiPolygon25D
        wkbGeometryCollection25D

    ctypedef enum OGRFieldType:
        OFTInteger
        OFTIntegerList
        OFTReal
        OFTRealList
        OFTString
        OFTStringList
        OFTWideString
        OFTWideStringList
        OFTBinary
        OFTDate
        OFTTime
        OFTDateTime
        OFTInteger64
        OFTInteger64List
        OFTMaxType

    ctypedef enum OGRFieldSubType:
        OFSTNone
        OFSTBoolean
        OFSTInt16
        OFSTFloat32

    ctypedef void* OGRDataSourceH
    ctypedef void* OGRFeatureDefnH
    ctypedef void* OGRFieldDefnH
    ctypedef void* OGRFeatureH
    ctypedef void* OGRGeometryH
    ctypedef void* OGRLayerH
    ctypedef void* OGRSFDriverH

    ctypedef struct OGREnvelope:
        double MinX
        double MaxX
        double MinY
        double MaxY


cdef extern from "ogr_srs_api.h":
    ctypedef void* OGRSpatialReferenceH

    int                     OSRAutoIdentifyEPSG(OGRSpatialReferenceH srs)
    const char*             OSRGetAuthorityName(OGRSpatialReferenceH srs, const char *key)
    const char*             OSRGetAuthorityCode(OGRSpatialReferenceH srs, const char *key)
    OGRErr                  OSRExportToWkt(OGRSpatialReferenceH srs, char **params)

    int                     OSRSetFromUserInput(OGRSpatialReferenceH srs, const char *pszDef)
    OGRSpatialReferenceH    OSRNewSpatialReference(const char *wkt)
    void                    OSRRelease(OGRSpatialReferenceH srs)


cdef extern from "ogr_api.h":
    int             OGRGetDriverCount()
    OGRSFDriverH    OGRGetDriver(int)

    OGRDataSourceH  OGR_Dr_Open(OGRSFDriverH driver, const char *path, int bupdate)
    const char*     OGR_Dr_GetName(OGRSFDriverH driver)

    OGRFeatureH     OGR_F_Create(OGRFeatureDefnH featuredefn)
    void            OGR_F_Destroy(OGRFeatureH feature)

    int64_t         OGR_F_GetFID(OGRFeatureH feature)
    OGRGeometryH    OGR_F_GetGeometryRef(OGRFeatureH feature)
    GByte*          OGR_F_GetFieldAsBinary(OGRFeatureH feature, int n, int *s)
    int             OGR_F_GetFieldAsDateTime(OGRFeatureH feature, int n, int *y, int *m, int *d, int *h, int *m, int *s, int *z)
    double          OGR_F_GetFieldAsDouble(OGRFeatureH feature, int n)
    int             OGR_F_GetFieldAsInteger(OGRFeatureH feature, int n)
    long            OGR_F_GetFieldAsInteger64(OGRFeatureH feature, int n)
    const char*     OGR_F_GetFieldAsString(OGRFeatureH feature, int n)
    int             OGR_F_IsFieldSetAndNotNull(OGRFeatureH feature, int n)
    void            OGR_F_SetFieldDateTime(OGRFeatureH feature, int n, int y, int m, int d, int hh, int mm, int ss, int tz)
    void            OGR_F_SetFieldDouble(OGRFeatureH feature, int n, double value)
    void            OGR_F_SetFieldInteger(OGRFeatureH feature, int n, int value)
    void            OGR_F_SetFieldInteger64(OGRFeatureH feature, int n, long long value)
    void            OGR_F_SetFieldString(OGRFeatureH feature, int n, char *value)
    void            OGR_F_SetFieldBinary(OGRFeatureH feature, int n, int l, unsigned char *value)
    void            OGR_F_SetFieldNull(OGRFeatureH feature, int n)  # new in GDAL 2.2
    OGRErr          OGR_F_SetGeometryDirectly(OGRFeatureH feature, OGRGeometryH geometry)

    OGRFeatureDefnH     OGR_FD_Create(const char *name)
    int                 OGR_FD_GetFieldCount(OGRFeatureDefnH featuredefn)
    OGRFeatureDefnH     OGR_FD_GetFieldDefn(OGRFeatureDefnH featuredefn, int n)
    OGRwkbGeometryType  OGR_FD_GetGeomType(OGRFeatureDefnH featuredefn)

    OGRFieldDefnH   OGR_Fld_Create(const char *name, OGRFieldType fieldtype)
    void            OGR_Fld_Destroy(OGRFieldDefnH fielddefn)
    const char*     OGR_Fld_GetNameRef(OGRFieldDefnH fielddefn)
    int             OGR_Fld_GetPrecision(OGRFieldDefnH fielddefn)
    OGRFieldSubType OGR_Fld_GetSubType(OGRFieldDefnH fielddefn)
    int             OGR_Fld_GetType(OGRFieldDefnH fielddefn)
    int             OGR_Fld_GetWidth(OGRFieldDefnH fielddefn)
    void            OGR_Fld_Set(OGRFieldDefnH fielddefn, const char *name, int fieldtype, int width, int precision, int justification)
    void            OGR_Fld_SetPrecision(OGRFieldDefnH fielddefn, int n)
    void            OGR_Fld_SetWidth(OGRFieldDefnH fielddefn, int n)

    void            OGR_Fld_SetSubType(OGRFieldDefnH fielddefn, OGRFieldSubType subtype)

    OGRGeometryH    OGR_G_CreateGeometry(int wkbtypecode)
    void            OGR_G_DestroyGeometry(OGRGeometryH geometry)
    void            OGR_G_ExportToWkb(OGRGeometryH geometry, int endianness, unsigned char *buffer)
    void            OGR_G_GetEnvelope(OGRGeometryH geometry, OGREnvelope* envelope)
    OGRErr          OGR_G_ImportFromWkb(OGRGeometryH geometry, const void *bytes, int nbytes)
    int             OGR_G_IsMeasured(OGRGeometryH geometry)
    void            OGR_G_SetMeasured(OGRGeometryH geometry, int isMeasured)
    int             OGR_G_Is3D(OGRGeometryH geometry)
    void            OGR_G_Set3D(OGRGeometryH geometry, int is3D)
    int             OGR_G_WkbSize(OGRGeometryH geometry)

    int                 OGR_GT_HasM(OGRwkbGeometryType eType)
    int                 OGR_GT_HasZ(OGRwkbGeometryType eType)
    OGRwkbGeometryType  OGR_GT_SetModifier(OGRwkbGeometryType eType, int setZ, int setM)

    OGRErr                  OGR_L_CreateFeature(OGRLayerH layer, OGRFeatureH feature)
    OGRErr                  OGR_L_CreateField(OGRLayerH layer, OGRFieldDefnH fielddefn, int flexible)
    const char*             OGR_L_GetName(OGRLayerH layer)
    OGRSpatialReferenceH    OGR_L_GetSpatialRef(OGRLayerH layer)
    int                     OGR_L_TestCapability(OGRLayerH layer, const char *name)
    OGRFeatureDefnH         OGR_L_GetLayerDefn(OGRLayerH layer)
    OGRFeatureH             OGR_L_GetNextFeature(OGRLayerH layer)
    OGRFeatureH             OGR_L_GetFeature(OGRLayerH layer, int nFeatureId)
    void                    OGR_L_ResetReading(OGRLayerH layer)
    OGRErr                  OGR_L_SetAttributeFilter(OGRLayerH hLayer, const char* pszQuery)
    OGRErr                  OGR_L_SetNextByIndex(OGRLayerH layer, int nIndex)
    int                     OGR_L_GetFeatureCount(OGRLayerH layer, int m)
    void                    OGR_L_SetSpatialFilterRect(OGRLayerH layer, double xmin, double ymin, double xmax, double ymax)

    void            OGRSetNonLinearGeometriesEnabledFlag(int bFlag)
    int             OGRGetNonLinearGeometriesEnabledFlag()

    int             OGRReleaseDataSource(OGRDataSourceH ds)

    const char*     OLCStringsAsUTF8
    const char*     OLCRandomRead
    const char*     OLCFastSetNextByIndex
    const char*     OLCFastSpatialFilter


cdef extern from "gdal.h":
    ctypedef enum GDALDataType:
        GDT_Unknown
        GDT_Byte
        GDT_UInt16
        GDT_Int16
        GDT_UInt32
        GDT_Int32
        GDT_Float32
        GDT_Float64
        GDT_CInt16
        GDT_CInt32
        GDT_CFloat32
        GDT_CFloat64
        GDT_TypeCount

    int GDAL_OF_UPDATE
    int GDAL_OF_READONLY
    int GDAL_OF_VECTOR
    int GDAL_OF_VERBOSE_ERROR

    ctypedef void* GDALDatasetH
    ctypedef void* GDALDriverH

    void GDALAllRegister()

    GDALDatasetH    GDALCreate(OGRSFDriverH driver,
                               const char * pszFilename,
                               int nXSize,
                               int nYSize,
                               int nBands,
                                GDALDataType eBandType,
                                char ** papszOptions)

    OGRLayerH       GDALDatasetCreateLayer(GDALDatasetH ds,
                                  const char * pszName,
                                  OGRSpatialReferenceH hSpatialRef,
                                  int eType,
                                  char ** papszOptions)

    int             GDALDatasetDeleteLayer(GDALDatasetH hDS, int iLayer)

    GDALDriverH     GDALGetDatasetDriver(GDALDatasetH ds)
    GDALDriverH     GDALGetDriverByName(const char * pszName)
    GDALDatasetH    GDALOpenEx(const char * pszFilename,
                               unsigned int nOpenFlags,
                               const char *const *papszAllowedDrivers,
                               const char *const *papszOpenOptions,
                               const char *const *papszSiblingFiles)

    void            GDALClose(GDALDatasetH ds)
    int             GDALDatasetGetLayerCount(GDALDatasetH ds)
    OGRLayerH       GDALDatasetGetLayer(GDALDatasetH ds, int iLayer)
    OGRLayerH       GDALDatasetGetLayerByName(GDALDatasetH ds, char * pszName)
    OGRErr          GDALDatasetStartTransaction(GDALDatasetH ds, int bForce)
    OGRErr          GDALDatasetCommitTransaction(GDALDatasetH ds)
    OGRErr          GDALDatasetRollbackTransaction(GDALDatasetH ds)
    const char*     GDALVersionInfo(const char *pszRequest)


cdef get_string(const char *c_str, str encoding=*)