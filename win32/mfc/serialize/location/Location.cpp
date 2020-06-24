#include <Location.h>


CLocation::CLocation()
    : m_x(-1), m_y(-1) { } 

CLocation::CLocation(WORD x, WORD y)
    : m_x(x), m_y(y) { }

CLocation::~CLocation() { }

void CLocation::Serialize(CArchive& archive) {
  CObject::Serialize(archive);

  if(archive.IsStoring()) {
    archive << m_x << m_y;
  } else {
    archive >> m_x >> m_y;
  }
}

IMPLEMENT_SERIAL(CLocation, CObject, VERSIONABLE_SCHEMA | 0xcafe)

