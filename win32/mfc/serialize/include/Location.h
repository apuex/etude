#pragma once

#include <afx.h>

class CLocation : public CObject {
public:
  DECLARE_SERIAL(CLocation)
  CLocation();
  CLocation(WORD x, WORD y);
  virtual ~CLocation();

  void Serialize(CArchive& archive);

private:
  WORD    m_x;
  WORD    m_y;
};
