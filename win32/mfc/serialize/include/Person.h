#pragma once

#include <afx.h>

class CPerson : public CObject {
public:
  DECLARE_SERIAL(CPerson)
  CPerson();
  CPerson(const CString& name, WORD number);
  virtual ~CPerson();

  void Serialize(CArchive& archive);

private:
  CString m_name;
  WORD    m_number;
};
