#include <Person.h>


CPerson::CPersion() { }

CPerson::CPerson(const CString& name, WORD number)
    : m_name(name), m_number(number) { }

CPerson::~CPersion() { }

void CPerson::Serialize(CArchive& archive) {
  CObject::Serialize(archive);

  if(archive.IsStoring()) {
    archive << m_name << m_number;
  } else {
    archive >> m_name >> m_number;
  }
}

IMPLEMENT_SERIAL(CPerson, CObject, VERSIONABLE_SCHEMA | 0)

