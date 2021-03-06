// ZipAddCommon.h

#ifndef __ZIP_ADD_COMMON_H
#define __ZIP_ADD_COMMON_H

#include "../../ICoder.h"
#include "../../IProgress.h"

#include "../../Common/CreateCoder.h"
#include "../../Common/FilterCoder.h"

#include "../../Compress/CopyCoder.h"

#include "../../Crypto/ZipCrypto.h"
#include "../../Crypto/WzAes.h"

#include "ZipCompressionMode.h"

namespace NArchive {
namespace NZip {

struct CCompressingResult
{
  UInt64 UnpackSize;
  UInt64 PackSize;
  UInt32 CRC;
  UInt16 Method;
  Byte ExtractVersion;
};

class CAddCommon
{
  CCompressionMethodMode _options;
  NCompress::CCopyCoder *_copyCoderSpec;
  CMyComPtr<ICompressCoder> _copyCoder;

  CMyComPtr<ICompressCoder> _compressEncoder;

  CFilterCoder *_cryptoStreamSpec;
  CMyComPtr<ISequentialOutStream> _cryptoStream;

  NCrypto::NZip::CEncoder *_filterSpec;
  NCrypto::NWzAes::CEncoder *_filterAesSpec;

  CMyComPtr<ICompressFilter> _zipCryptoFilter;
  CMyComPtr<ICompressFilter> _aesFilter;


public:
  CAddCommon(const CCompressionMethodMode &options);
  HRESULT Compress(
      DECL_EXTERNAL_CODECS_LOC_VARS
      ISequentialInStream *inStream, IOutStream *outStream,
      ICompressProgressInfo *progress, CCompressingResult &operationResult);
};

}}

#endif
