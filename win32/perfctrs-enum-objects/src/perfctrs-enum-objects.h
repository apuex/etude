#ifndef __PERFCTRS_ENUM_OBJECTS__
#define __PERFCTRS_ENUM_OBJECTS__

typedef void(*pdh_enum_object_items_cb_t)(PWSTR);

void
pdh_enum_objects(
		LPCWSTR szDataSource,
		LPCWSTR szMachineName,
		pdh_enum_object_items_cb_t pEnumItemsFun
		);

void 
pdh_enum_object_items(
		PWSTR pObjectName
		);
#endif // __PERFCTRS_ENUM_OBJECTS__
