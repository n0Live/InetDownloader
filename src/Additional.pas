unit Additional;

interface

uses SysUtils, Windows, Classes, Contnrs, winsock;

const
  WININET_MODULE = 'wininet.dll';
  LNBR = #13#10;

  MIN_SIZE_TO_CALCULATE = 32768;
  INTERNET_OPTION_MAX_CONNS_PER_SERVER = 73;
  INTERNET_OPTION_MAX_CONNS_PER_1_0_SERVER = 74;

//==== ��������� ��������� ��������� ============
resourcestring
  MSG_FORMAT_ERROR = LNBR + '%s (%d)';
  MSG_NOT_FILL_FILENAME = '�� ������� ��� ����������� �����';
  MSG_NOT_FILL_URL = '�� ��������� URL ���������� ������';
  MSG_DOWNLOAD_ONLY = '� �������� ����������� ���������� �������� ����� �� ������ ����������';
  MSG_DOWNOLOADING_DATA_OK = '��������� ������ ������� ���������';
  MSG_DOWNOLOADING_DATA_ERROR = '��������� ������ ����������� ��������';
  MSG_UPLOADING_DATA_OK = '�������� ������ ������� ���������';
  MSG_UPLOADING_DATA_ERROR = '�������� ������ ����������� ��������';
  MSG_URL_ERROR = '������ ��� ������� ������ URL:';
  MSG_PARAMETERS_INFO = '������� ��������� ������ �� ���������� �����������:' + LNBR + '%s';
  MSG_SERVER_ANSVER = '����� �������:' + LNBR + '%s';
  MSG_INTERNET_OPEN_OK = '�������� �������� ������: OK';
  MSG_INTERNET_OPEN_ERROR = '������ ��� �������� �������� ������:';
  MSG_INTERNET_CONNECT_OK = '���������� � %s: OK';
  MSG_INTERNET_CONNECT_ERROR = '������ ��� c��������� � %s:';
  MSG_OPEN_REQUEST_OK = '�������� HTTP %s-�������: OK';
  MSG_OPEN_REQUEST_ERROR = '������ ��� �������� HTTP %s-�������:';
  MSG_FTP_FIND_FILE_OK = '����� FTP-����� "%s": OK';
  MSG_FTP_FIND_FILE_ERROR = '������ ������ FTP-����� "%s":';
  MSG_OPEN_FTP_OK = '�������� FTP-����� "%s": OK';
  MSG_OPEN_FTP_ERROR = '������ ��� �������� FTP-����� "%s":';
  MSG_FTP_COMMAND_OK = '���������� ������� FTP "%s":' + LNBR + '%s';
  MSG_FTP_COMMAND_ERROR = '������ ���������� ������� FTP "%s":';
  MSG_SEND_REQUEST_OK = '������� HTTP �������: OK';
  MSG_SEND_REQUEST_ERROR = '������ ��� �������� HTTP �������:';
  MSG_QUERY_INFO_ERROR = '������ ��� ��������� ���������� �� HTTP �������:';
  MSG_QUERY_INFO_HTTP_ERROR = '������ ��� ��������� ���������� �� HTTP �������:' + LNBR + '%s (%d)';
  MSG_QUERY_INFO_HTTP = '�������� ����������� � ����� �������:' + LNBR + '%s (%d)';
  MSG_QUERY_INFO_OK = '��������� ���������� �� HTTP �������: OK';
  MSG_QUERY_CONTENT_LENGTH_OK = '������ ���������� ������: %s';
  MSG_QUERY_CONTENT_LENGTH_ERROR = '������ ���������� ������: �� ������� ����������';
  MSG_DOWNLOAD_STRING_OK = '��������� ������ � ���� ������: OK';
  MSG_DOWNLOAD_STREAM_OK = '��������� ������ � ���� ������: OK';
  MSG_DOWNLOAD_FILE_OK = '�������� ����� "%s": OK';
  MSG_DOWNLOAD_FILE_ERROR = '������ ��� �������� ����� "%s":';
  MSG_DOWNLOAD_ERROR = '������ ��������� ������, ������� #%d ����� %d ��';
  MSG_ABORT = '�������� �������� �������������';
  MSG_OPEN_FILE_ERROR = '������ ������� � ����� "%s":';
  MSG_READ_FILE_ERROR = '������ ������ ����� "%s":';
  MSG_INTERNET_WRITE_FILE_ERROR = '������ ������ ����� �� ������:';
  MSG_PING = '����� ������� ��: %d ��';
  MSG_FILE_SIZE = '������ �����: %s';
  MSG_GIGABYTES = '��';
  MSG_MEGABYTES = '��';
  MSG_KILOBYTES = '��';
  MSG_BYTES = '����';
  MSG_FTP_FILE_INFO = '��� �����: %s' + LNBR + '��������: %s' + LNBR + '������: %s' + LNBR +
    '������: %s' + LNBR + '�������: %s' + LNBR + '������: %s';
//===============================================

type
  //����� ��� �������� � ���������� ������� ���������� �������
  TThreadList = class(TObjectList)
  protected
    function GetItem(Index: Integer): TThread;
    procedure SetItem(Index: Integer; AThread: TThread);
  public
    function Add(AThread: TThread): Integer;
    function Extract(Item: TThread): TThread;
    function Remove(AThread: TThread): Integer;
    function IndexOf(AThread: TThread): Integer;
    procedure Insert(Index: Integer; AThread: TThread);
    function First: TThread;
    function Last: TThread;
    property Items[Index: Integer]: TThread read GetItem write SetItem; default;
  end;

//===���� �� ������ WinSock====
  PHostEnt = ^THostEnt;
  {$EXTERNALSYM hostent}
  hostent = record
    h_name: PChar;
    h_aliases: ^PChar;
    h_addrtype: Smallint;
    h_length: Smallint;
    case Byte of
      0: (h_addr_list: ^PChar);
      1: (h_addr: ^PChar)
  end;
  THostEnt = hostent;

  PWSAData = ^TWSAData;
  {$EXTERNALSYM WSAData}
  WSAData = record // !!! also WSDATA
    wVersion: Word;
    wHighVersion: Word;
    szDescription: array[0..256{WSADESCRIPTION_LEN}] of Char;
    szSystemStatus: array[0..128{WSASYS_STATUS_LEN}] of Char;
    iMaxSockets: Word;
    iMaxUdpDg: Word;
    lpVendorInfo: PChar;
  end;
  TWSAData = WSAData;

  {$EXTERNALSYM SunB}
  SunB = packed record
    s_b1, s_b2, s_b3, s_b4: Char;
  end;
  {$EXTERNALSYM SunW}
  SunW = packed record
    s_w1, s_w2: Word;
  end;
  PInAddr = ^TInAddr;
  {$EXTERNALSYM in_addr}
  in_addr = record
    case integer of
      0: (S_un_b: SunB);
      1: (S_un_w: SunW);
      2: (S_addr: Longint);
  end;
  TInAddr = in_addr;

//====������� ���������� wsock32.dll====
function gethostname(name: PChar; len: Integer): Integer; stdcall; external 'wsock32.dll' name 'gethostname';
function gethostbyname(name: PChar): PHostEnt; stdcall; external 'wsock32.dll' name 'gethostbyname';
function WSAStartup(wVersionRequired: word; var WSData: TWSAData): Integer; stdcall; external 'wsock32.dll' name 'WSAStartup';
function WSACleanup: Integer; stdcall; external 'wsock32.dll' name 'WSACleanup';
function inet_ntoa(inaddr: TInAddr): PChar; stdcall; external 'wsock32.dll' name 'inet_ntoa';
//======================================

function IIF (Expr: boolean; TrueResult, FalseResult: string): string; overload;
function IIF (Expr: boolean; TrueResult, FalseResult: Cardinal): Cardinal; overload;
function IIF (Expr: boolean; TrueResult, FalseResult: boolean): boolean; overload;
function FormatNumber(const Value: Cardinal): Cardinal;
function UrlDecode(Url: string): string;
function GetFileSize(FileName: string): Cardinal;
function FormatFileSize(Size: Integer): string;
function WinInetErrorMessage(ErrorCode: Cardinal): string;
function FileTimeToStr(FileTime: TFileTime): string;
function GetLocalIp: string;
function FileAttrToStr(Attr: Integer): string;
function GetFileVersion(const FileName: string): string;

implementation

// ���������������� IF (������������� ������ ��� �����, ������������� � ������� ����������)
function IIF (Expr: boolean; TrueResult, FalseResult: string): string; overload;
begin
  if Expr then
    Result := TrueResult
  else
    Result := FalseResult;
end;

function IIF (Expr: boolean; TrueResult, FalseResult: Cardinal): Cardinal; overload;
begin
  if Expr then
    Result := TrueResult
  else
    Result := FalseResult;
end;

function IIF (Expr: boolean; TrueResult, FalseResult: boolean): boolean; overload;
begin
  if Expr then
    Result := TrueResult
  else
    Result := FalseResult;
end;

//����������� ����� � ���� BASE*N
function FormatNumber(const Value: Cardinal): Cardinal;
const
  BASE = 256; //������� �����, �� �������� ���� ���������
  MIN_VALUE = 4; //����������� ������������ ��������
var
  i: byte;
  tmpVal: Cardinal;
begin
  if Value <= MIN_VALUE then //���� �������� ������ ������������, �� ���������� �����������
    Result := MIN_VALUE
  else if Value >= BASE then  //���� ������������� �������� ������ ��������, �� �������� ��� � ���� BASE*N
    begin
      Result := BASE * (Value div BASE);
      if (Value - Result) >= BASE / 2 then
        Result := Result + BASE;
    end
  else //����� �������� ����� � ���� 2^i
    begin
      i := 1;
      tmpVal := Value;
      while (tmpVal > 2) do
        begin
          tmpVal := tmpVal div 2;
          Inc(i);
        end;
      Result := 1 shl i; //������������ ����� � ���� 2^i
    end;
end;

//������������� URL-������: �������� "%HH" �� ��������������� ������
//� ��������� �� ���� ������ ���� �������, ��� ������� � ����� � ������������ � ������������ �����������
function UrlDecode(Url: string): string;

  function HexToChar(W: word): Char;
  asm
   cmp ah, 030h
   jl @@error
   cmp ah, 039h
   jg @@10
   sub ah, 030h
   jmp @@30
@@10:
   cmp ah, 041h
   jl @@error
   cmp ah, 046h
   jg @@20
   sub ah, 041h
   add ah, 00Ah
   jmp @@30
@@20:
   cmp ah, 061h
   jl @@error
   cmp al, 066h
   jg @@error
   sub ah, 061h
   add ah, 00Ah
@@30:
   cmp al, 030h
   jl @@error
   cmp al, 039h
   jg @@40
   sub al, 030h
   jmp @@60
@@40:
   cmp al, 041h
   jl @@error
   cmp al, 046h
   jg @@50
   sub al, 041h
   add al, 00Ah
   jmp @@60
@@50:
   cmp al, 061h
   jl @@error
   cmp al, 066h
   jg @@error
   sub al, 061h
   add al, 00Ah
@@60:
   shl al, 4
   or al, ah
   ret
@@error:
   xor al, al
  end;

  function GetCh(P: PChar; var Ch: Char): Char;
  begin
    Ch := P^;
    Result := Ch;
  end;

var
  P: PChar;
  Ch: Char;
begin
  Result := '';
  if Url = '' then Exit;
  P := @Url[1];
  while GetCh(P, Ch) <> #0 do
  begin
    case Ch of
      '+': Result := Result + ' ';
      '%':
        begin
          Inc(P);
          Result := Result + HexToChar(PWord(P)^);
          Inc(P);
        end;
    else
      Result := Result + Ch;
    end;
    Inc(P);
  end;
  Result := UTF8Decode(Result);
end;

//���������� ������ �����, ���� ���� �� ���������� - ���������� (-1)
function GetFileSize(FileName: string): Cardinal;
var iFileHandle: Integer;
begin
  iFileHandle := FileOpen(FileName, fmShareDenyNone);
  if iFileHandle <> -1 then
    try
      //������ ����� ������������ ��������� � ����� ������������� �����
      Result := FileSeek(iFileHandle, 0, FILE_END);
    finally
      //��������� ����
      FileClose(iFileHandle);
    end
  else
    Result := DWORD(-1);
end;

//������� ������ ����� � ����������������� ���� (����, ��, �� ...)
function FormatFileSize(Size: Integer): string;
begin
  if Size < $3E8{1000} then
    Result := IntToStr(Size) + ' ' + MSG_BYTES
  else if Size < $F4240{1000000} then
    Result := Format('%.2f %s', [Size / $400{1024}, MSG_KILOBYTES])
  else if Size < $3B9ACA00{1000000000} then
    Result := Format('%.2f %s', [Size / $100000{1048576}, MSG_MEGABYTES])
  else
    Result := Format('%.2f %s', [Size / $40000000{1073741824}, MSG_GIGABYTES])
end;

// ��������� ������������������ ��������� �� ������ WinInet �� ���� ������
function WinInetErrorMessage(ErrorCode: Cardinal): string;
var
  dwSize: DWORD;      //������ ���������� ���������
  lpszTemp: PChar;    //��������� �� ���������� ������
  Len: Integer;       //����� ����������� ������
begin
  dwSize := 512;   //������������� ������ ���������� ���������
  lpszTemp := nil; //��NULL��� ��������� �� ���������� ������
  Len := 0;
  try
    GetMem(lpszTemp, dwSize); //�������� ������ ��� ���������� ������
    //����������� ����������������� ��������� �� ������
    Len := FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or //��������� ������
                         FORMAT_MESSAGE_FROM_HMODULE,  //������ ���������� ������
                         Pointer(GetModuleHandle(WININET_MODULE)),//��������� �� ����� ������ 'wininet.dll'
                         ErrorCode,                    //��� ������, ��� �������� ����� �������� ��������
                         LANG_NEUTRAL,                 //����, �� ������� ��������� �������� ������ (LANG_NEUTRAL - ���� ������������� Windows)
                         lpszTemp,                     //��������� �� ���������� ������
                         dwSize,                       //������ ���������� ���������
                         nil);                         //��������� (�� ������������)
    //������� ���������� ������ �� ������������ �������� � �����
    while (Len > 0) and (lpszTemp[Len - 1] in [#0..#32, '.']) do Dec(Len);
  finally
    //�������� Result ����������� �������
    SetString(Result, lpszTemp, Len);
    //��������� ������
    FreeMem(lpszTemp)
  end
end;

//�������������� ��������� TFileTime � ���������� ����
function FileTimeToStr(FileTime: TFileTime): string;
var
  LocalFileTime: TFileTime;  //������ ��������� �����
  FileDate: Integer;         //������ ����� ����� � ������� Dos
  DateTime: TDateTime;       //������ ����� � ������� TDateTime
begin
  //��������� ����� ����� �� UMT � ���������
  FileTimeToLocalFileTime(FileTime, LocalFileTime);
  //��������� ����� ����� � Dos ������
  if FileTimeToDosDateTime(LocalFileTime, LongRec(FileDate).Hi,
    LongRec(FileDate).Lo) then
      begin
        //��������� ����� � ������ TDateTime
        DateTime := FileDateToDateTime(FileDate);
        //��������� TDateTime � ������
        Result := DateTimeToStr(DateTime);
      end
  else
    Result := '';
end;

//���������� ������ ��������� IP
function GetLocalIp: string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  AWSAData: WSAData;
  HostName: array [0..63] of Char;
  PHost: PHostEnt;
  InAddr: PaPInAddr;
  i: integer;
begin
 Result := 'N/A';
 //�������������� ������������� ���������� WinSocks
 if WSAStartup(MAKEWORD(1, 1), AWSAData) = 0 then
   begin
     //���������� ��� ����������
     if gethostname(HostName, SizeOf(HostName)) <> -1 then
       begin
          //�������� ��������� ����� ��� ����� �����
          PHost := gethostbyname(HostName);
          if PHost <> nil then
            begin
              //��������� ������ ������� �����
              InAddr := PaPInAddr(PHost^.h_addr_list);
              if InAddr^[0] <> nil then
                begin
                  //�������� ������ �����
                  Result := String(inet_ntoa(InAddr^[0]^));
                  //����������� ��������� ������
                  i := 1;
                  while InAddr^[i] <> nil do
                    begin
                      Result := Result + '; ' +String(inet_ntoa(InAddr^[i]^));
                      Inc(i);
                    end;
                end;
            end;
       end;
   end;
 //���������� ������������� ���������� WinSocks
 WSACleanup;
end;

//������� ��������� ����� � ��������� ���
function FileAttrToStr(Attr: Integer): string;
begin
  Result := '-------';
  //����������
  if (Attr and FILE_ATTRIBUTE_DIRECTORY) <> 0 then Result[1] := 'D';
  //���������� ���� (��� ������� ������ ���������)
  if (Attr and FILE_ATTRIBUTE_NORMAL)    <> 0 then Result[2] := 'N';
  //������
  if (Attr and FILE_ATTRIBUTE_COMPRESSED)<> 0 then Result[3] := 'C';
  //��������
  if (Attr and FILE_ATTRIBUTE_ARCHIVE)   <> 0 then Result[4] := 'A';
  //�������
  if (Attr and FILE_ATTRIBUTE_HIDDEN)    <> 0 then Result[5] := 'H';
  //���������
  if (Attr and FILE_ATTRIBUTE_SYSTEM)    <> 0 then Result[6] := 'S';
  //������ ������
  if (Attr and FILE_ATTRIBUTE_READONLY)  <> 0 then Result[7] := 'R';
end;

//����� ������ ����� � ���� ������
function GetFileVersion(const FileName: string): string;
type
  PDWORD = ^DWORD;
  PLangAndCodePage = ^TLangAndCodePage;
  TLangAndCodePage = packed record
    wLanguage: WORD;
    wCodePage: WORD;
  end;
  PLangAndCodePageArray = ^TLangAndCodePageArray;
  TLangAndCodePageArray = array[0..0] of TLangAndCodePage;
var
  loc_InfoBufSize: DWORD;
  loc_InfoBuf: PChar;
  loc_VerBufSize: DWORD;
  loc_VerBuf: PChar;
  cbTranslate: DWORD;
  lpTranslate: PDWORD;
  i: DWORD;
begin
  Result := '';
  loc_InfoBufSize := GetFileVersionInfoSize(PChar(FileName), loc_InfoBufSize);
  if loc_InfoBufSize > 0 then
  begin
    loc_VerBuf := nil;
    loc_InfoBuf := AllocMem(loc_InfoBufSize);
    try
      if not GetFileVersionInfo(PChar(FileName), 0, loc_InfoBufSize, loc_InfoBuf) then
        Exit;
      if not VerQueryValue(loc_InfoBuf, '\\VarFileInfo\\Translation',
        Pointer(lpTranslate), cbTranslate) then
          Exit;
      for i := 0 to (cbTranslate div SizeOf(TLangAndCodePage)) - 1 do
      begin
        if VerQueryValue(loc_InfoBuf,
                         PChar(Format('StringFileInfo\0%x0%x\FileVersion',
                               [PLangAndCodePageArray(lpTranslate)[i].wLanguage,
                                PLangAndCodePageArray(lpTranslate)[i].wCodePage])),
                         Pointer(loc_VerBuf),
                         loc_VerBufSize)
        then
          begin
            Result := loc_VerBuf;
            Break;
          end;
      end;
    finally
      FreeMem(loc_InfoBuf, loc_InfoBufSize);
    end;
  end;
end;

//=============TThreadList==================
function TThreadList.GetItem(Index: Integer): TThread;
begin
  Result := (inherited GetItem(Index) as TThread);
end;

procedure TThreadList.SetItem(Index: Integer; AThread: TThread);
begin
  inherited SetItem(Index, AThread);
end;

function TThreadList.Add(AThread: TThread): Integer;
begin
  Result := inherited Add(AThread);
end;

function TThreadList.Extract(Item: TThread): TThread;
begin
  Result := (inherited Extract(Item) as TThread);
end;

function TThreadList.Remove(AThread: TThread): Integer;
begin
  Result := inherited Remove(AThread);
end;

function TThreadList.IndexOf(AThread: TThread): Integer;
begin
  Result := inherited IndexOf(AThread);
end;

procedure TThreadList.Insert(Index: Integer; AThread: TThread);
begin
  inherited Insert(Index, AThread);
end;

function TThreadList.First: TThread;
begin
  Result := (inherited First as TThread);
end;

function TThreadList.Last: TThread;
begin
  Result := (inherited Last as TThread);
end;
//==========================================

end.
