#ifndef __key_h__
#define __key_h__

class key {
 public:
  key() : id_(0), ts_(0) {
  }
  key(const key& k) : id_(k.id_), ts_(k.ts_) {
  }
  key(int id, int ts) : id_(id), ts_(ts) {
  }

  key& operator=(const key& k) {
    this->id_ = k.id_;
    this->ts_ = k.ts_;
    return (*this);
  }

  bool operator==(const key& k) const {
    if(this->id_ != k.id_) return false;
    if(this->ts_ != k.ts_) return false;
    return true;
  }

  bool operator<(const key& k) const {
    if(this->id_ < k.id_) return true; else if(this->id_ > k.id_) return false;
    if(this->ts_ < k.ts_) return true; else if(this->ts_ > k.ts_) return false;
    return false;
  }

  int id() const { return id_; }
  int ts() const { return ts_; }
 
 private:
  int id_;
  int ts_;
};


#endif // #define __key_h__
