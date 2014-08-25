{****************************************************}
{* ��������� InetDownloader                         *}
{* �����: Egor Krasnopolin                          *}
{* 09/07/2009                                       *}
{*                                                  *}
{* ��������� ������������ ��� ���������  ������  �� *}
{* ��������� � ���� �����, ������ ��� ������. ����� *}
{* ��� ������ ����������  ����� "��������" ����� �� *}
{* ������.                                          *}
{****************************************************}
{*                                                  *}
{* *** ��������: ***                                *}
{* AcceptTypes - ����������� ��� �������� ���� ���- *}
{*   ���.                                           *}
{* UserAgent - ������ ���������� �������� UserAgent.*}
{* AuthPassword -  ������,  ���  ��������������  �� *}
{*   �������.                                       *}
{* AuthUserName -  �����,  ���   ��������������  �� *}
{*   �������.                                       *}
{* AutoFileName - �������������,  ���  ���������  � *}
{*   TRUE - ��� ����� �������������  �������������, *}
{*   �� ������ ��������, ���������� �� ���������.   *}
{* BufferSize - ������  ������ ������/�������� ���- *}
{*   ���.  �������������  ����������  �  ���������� *}
{*   �����, ������������� � ������� ������.         *}
{* LoadCount -  ������ ����������� �����������, ����*}
{* LoadFrom - ��������, ������������ ������, ���    *}
{*   ��������� ������. ���� ������  ����������� ��- *}
{*   �������� �� �������, �� ��������  �����������- *}
{*   ���� ������ 0, � �������� LoadCount ���������- *}
{*   ���� �� �������� ��������������� ��������.     *}
{* FileName -  ���  �����������   �����,  �  ������ *}
{*   AutoFileName = TRUE - �� ����� �������� �����- *}
{*   �� ������ ���� � �����.                        *}
{* InternetAccessType - ��� ������� � ���������:    *}
{*   atDirect - ������ ����������;                  *}
{*   atPreconfig - ���������� ��������� �� �������; *}
{*   atProxy - ���������� ����� ������-������;      *}
{*   atPreconfigWithNoAutoProxy - ����������  ����- *}
{*     ����� ��  �������, ��  �������������  ������ *}
{*     Microsoft JScript ��� Internet Setup (INS).  *}
{* LocalIP - ��������� ��������� IP-����� ����������*}
{* Name - ��� ����������.                           *}
{* PostHeaders - ��������� POST/Custom-�������.     *}
{* PostQuery - ������ POST/Custom-�������.          *}
{* PostType - ��� ������������� POST/Custom-�������:*}
{*   ptNone - �������������� ��������� �� ����������*}
{*   ptHeaders - ���������(��� multipart/form-data);*}
{*   ptQuery - ������ (��� x-www-form-urlencoded).  *}
{* Proxy - �����  ������-�������  �  �������:       *}
{*   url:port ��� http=url:port ftp=url:port...     *}
{* ProxyBypass - ������ �������, ��� ������� �� ���-*}
{*   ������ ������������ ������-������. ������ ���- *}
{*   �������� �������� (;), ����������� ����������- *}
{*   ��� ����� � ������� <local>.                   *}
{* ProxyPassword - ������ � ������-�������.         *}
{* ProxyUserName - ����� � ������-�������.          *}
{* Referer - ������  �� ��������, � ������� ������- *}
{*   ��� ����� ������ �� ��������� ������.          *}
{* RepeatCount - ���������� �������� ��� ������ ��- *}
{*   ��������.                                      *}
{* RepeatOnError -  �������������,  ����  TRUE - �� *}
{*   ��� ������ ���������� ����� ��������� �������- *}
{*   ��������.                                      *}
{* RepeatTimeout - �����  �������� � �������������, *}
{*   ����� �������� ����� ��������� ���������������.*}
{* ReportLevel - ������� ���������  ����������, ��� *}
{*   ������ ���������� �������, ��� ������ �������- *}
{*   ������� ���� ����� ��������.                   *}
{*  ��������� ReportLevel:                          *}
{*  mResult - ��������� ����������;                 *}
{*  mProgress - ������ ������ � �������� ����������;*}
{*  mMessage - ������ ���������;                    *}
{*  mOk -  ��������   ���������   (������������   � *}
{*    mResult � mMessage);                          *}
{*  mError -  ������   ����������  (������������  � *}
{*    mResult � mMessage);                          *}
{*  mInfo - ��������������  ������  (������������ � *}
{*    mResult � mMessage);                          *}
{*  mDataSize - ����� ������ ����������/������������*}
{*    ������,  ����  (������������  �  mProgress  � *}
{*    mMessage);                                    *}
{*  mBytesRead - �������  ������ ����������/������- *}
{*    ������ ������, ���� (������������ � mProgress)*}
{*  mSpeed -  �������  ��������  ����������, ����/� *}
{*    (������������ � mProgress).                   *}
{* RequestMethod - ����� ������� �������. ��������- *}
{*   ������ ������: Get, Post � Head, �  ����� ���� *}
{*   ����������� ���������� ���������������� �����. *}
{*   ��� ����� ���������� �������� rmCustom � ����- *}
{*   ������ ����� SetCustomRequestMethod(Value).    *}
{*   ����������: ����� ���������� �������� rmCustom,*}
{*   ����� ������ SetCustomRequestMethod ����������!*}
{* ShowErrorDlg - �������������, ���� TRUE - �� ��� *}
{*   ��������� ������� ������� �����  �������� ���- *}
{*   ������� ����  ���  �������  ���������  ������� *}
{*   (���� ������/������, ��������� �����������).   *}
{* SpeedLimit - �����������  ��������,  ����/�. ��� *}
{*   0 - �������� ������������.                     *}
{* ThreadsList - ������ ��������� ������  ��  ����- *}
{*   ������ ������.                                 *}
{* Url - ������, ���������� ����� ��������� ������. *}
{* WaitOnWorkEnd - �������������, ���� TRUE - �� ��-*}
{*   �������� ��� � ���������  �� �����  ���������� *}
{*   ���� �� ���������� ����� ��������� ������.     *}
{* WininetVersion - ����������  ������ ������������ *}
{*   ���������� wininet.                            *}
{* WriteMethod - ����� ������ � ����:               *}
{*   wmRewrite - ���� ����� �����������, ���������- *}
{*     ���� ����� ���� ����������� ������, ��� ���- *}
{*     ��������� ������������.                      *}
{*   wmAppend - ������ ����� ���������� � ����� ��- *}
{*     ����������� �����, ������ �� �������������.  *}
{*   wmSaveBytePos - ������ �����  �������� � �� �� *}
{*     ����� �����, ������  ���  ����  �����.  ���� *}
{*     ���� �� ���������� ���  ��� ������ ��������- *}
{*     �� �� ����������, �� ���� ����� �����������. *}
{*     ������ �������������.                        *}
{*                                                  *}
{* *** ������: ***                                  *}
{* Abort[Index] - ���������� ���������� ����������� *}
{*   ������. �������� Index ���������� ����� ������ *}
{*   �����  ���������  ���������. Index  ������� �� *}
{*   ������ ThreadsList, ��������� �������� - 0.    *}
{*   ���  ������ ���  ���������� ����������� �����, *}
{*   ���������� ���������.                          *}
{* DownloadFile - �������� ������ � ���� �����.     *}
{* DownloadString - �������� ������ � ���� ������.  *}
{* DownloadStream - �������� ������ � ���� ������.  *}
{* GetMaxConnsPerServer(MaxConnsPer1_0Server,       *}
{*  MaxConnsPerServer) - ��������� �������� ��������*}
{*   ���������� ������������� ���������� �����������*}
{*   � ������ �������. ��������� ���������� -1 ���  *}
{*   �������.                                       *}
{* SetMaxConnsPerServer(MaxConnsPer1_0Server,       *}
{*  MaxConnsPerServer) - ����������  ��������  ����-*}
{*   ������ �������������  ���������� ����������� � *}
{*   ������ �������.                                *}
{* SetCustomRequestMethod(Value) - ��������� ������-*}
{*   ����������� ���� �������.  �������� Value ����-*}
{*   �������� ����� �������� ����������������� ���� *}
{*   �������. ���������� True - ���  ��������  ����-*}
{*   ����� ���� � False -  ���  ������� (����. ���� *}
{*   �������� ��������  RequestMethod ���������� �� *}
{*   rmCustom).                                     *}
{* UploadFile - ������ ���� �� http- (������� 'PUT')*}
{*   ���� ftp-������.                               *}
{* UploadString(Str) - ������ ������ Str  ��  http- *}
{*   (������� 'PUT') ���� ftp-������.               *}
{* UploadStream(Stream) - ������  �����  Stream  �� *}
{*   http- (������� 'PUT') ���� ftp-������.         *}
{*                                                  *}
{* *** �������: ***                                 *}
{* OnDownloadFileDone - ����������  ��� ����������  *}
{*   ��������� �����. �������� ��������� ���������: *}
{*   Sender - ��������� ������ �� ����;             *}
{*   FileName - ��� ����������� �����;              *}
{*   DataSize - ������ ������������� ������, ����;  *}
{*   BytesReaded - ������ ����������� ������, ����; *}
{*     ����� ���� ��� ������ DataSize(��� ��������� *}
{*     ����������), ��� � ������ (��� ������������� *}
{*     ���������� ��������);                        *}
{*   Result - ��������� ��������� ������ (����� ��� *}
{*     �������).                                    *}
{* OnDownloadStringDone - ���������� ��� ���������� *}
{*   ��������� ������. �������� ��������� ���������:*}
{*   Sender - ��������� ������ �� ����;             *}
{*   RecivedString - ������ � ����������� �������;  *}
{*   DataSize - ������ ������������� ������, ����;  *}
{*   BytesReaded - ������ ����������� ������, ����; *}
{*   Result - ��������� ��������� ������ (����� ��� *}
{*     �������).                                    *}
{* OnDownloadStreamDone - ���������� ��� ���������� *}
{*   ��������� ������. �������� ��������� ���������:*}
{*   Sender - ��������� ������ �� ����;             *}
{*   RecivedStream - ���������� ����� ������;       *}
{*   DataSize - ������ ������������� ������, ����;  *}
{*   BytesReaded - ������ ����������� ������, ����; *}
{*   Result - ��������� ��������� ������ (����� ��� *}
{*     �������).                                    *}
{* OnUploadDone - ���������� ��� ���������� ��������*}
{*   ������ �� ������. �������� ��������� ���������:*}
{*   Sender - ��������� ������ �� ����;             *}
{*   Adress - ������ � Url ������������ ������;     *}
{*   DataSize - ������ ������������� ������, ����;  *}
{*   BytesWriten - ������ ���������� ������, ����;  *}
{*   Result - ��������� ��������� ������ (����� ��� *}
{*     �������).                                    *}
{* OnGiveMessage - ���������� ��� ��������� ������- *}
{*   ��� �� ������. �������� ��������� ���������:   *}
{*   Sender - ��������� ������ �� �����;            *}
{*   MsgTypes - ��� ��������� (��. ReportLevel);    *}
{*   Msg - ���������� ���������.                    *}
{*                                                  *}
{****************************************************}

unit InetDownloader;

interface

uses
  Windows, Messages, SysUtils, Classes,
  WinInet2, Additional;

type
  //��� �������
  TRequestMethod = (rmGet, rmPost, rmHead, rmCustom);
  //������ ������� �������� � ����� ���������
  TPostType = (ptNone, ptQuery, ptHeaders);
  //��� ����������� ���������
  TMsgType = (mOk,          //�������� ����������
              mError,       //������
              mInfo,        //�������������� ��������
              mResult,      //��������� ���������� ������
              mMessage,     //������ ���������
              mProgress,    //�������� ����������
              mDataSize,    //����� ������ ���������� ������, ���� (0 - ���� �� ������� ����������)
              mBytesReaded, //������ ����������� ������, ����. ������������� � ������ ���������.
              mSpeed);      //������� ��������, ����/�
  TMsgTypes = set of TMsgType;
  //��� �������� ������
  TTypeOfData = (odFile,   //����
                    odString, //������
                    odStream);//�����
  //��� �������
  TInternetAccessType = (atPreconfig,                //���������� ��������� �� �������
                         atDirect,                   //������ ������
                         atProxy,                    //����� ������
                         atPreconfigWithNoAutoProxy);//���������� ��������� �� ������� � ������������� ������ Microsoft JScript ��� Internet Setup (INS)
  //����� ������ � ����
  TWriteMethod = (wmRewrite,     //���������� (+ ������������� ���� ������ �����)
                  wmAppend,      //���������� (���������� ������ ������������ � ����� �����)
                  wmSaveBytePos);//� ����������� ������� (������������� ���� ������ �����, ������ ������������ � �� �� ������� �����, �� ������� ��� ���� ���������)
                                 //���� ���� ���������� � ��� ������ ������������� �����������, �� ������ ������ ������������ ������ ����� �����

  TOnGiveMessage = procedure (Sender: TObject; MsgTypes: TMsgTypes; Msg: string) of object;  //��������� ��������� ����������� ���������
  TOnDownloadFileDone = procedure (Sender: TObject; FileName: string; DataSize, BytesReaded: Cardinal; Result: boolean) of object; //��������� ��������� ���������� ���������� �����
  TOnDownloadStreamDone = procedure (Sender: TObject; RecivedStream: TMemoryStream; DataSize, BytesReaded: Cardinal; Result: boolean) of object; //��������� ��������� ���������� ���������� ������
  TOnDownloadStringDone = procedure (Sender: TObject; RecivedString: string; DataSize, BytesReaded: Cardinal; Result: boolean) of object; //��������� ��������� ���������� ��������� ������
  TOnUploadDone = procedure (Sender: TObject; Adress: string; DataSize, BytesWriten: Cardinal; Result: boolean) of object; //��������� ��������� ���������� ������� ������ �� ������

  //��������� ����������
  TParameters = record
    AcceptTypes: string;      //  ����������� ���� ���������� ������ (*/* - ��� ����)
    UserAgent: string;        //  User Agent (��-��������� - ��� ���������)
    Url: string;              //  Url �����, ������� ����� ��������
    AuthUserName: string;     //  ��� ������������ ��� Autentification: Basic
    AuthPassword: string;     //  ������ ��� Autentification: Basic
    FileName: string;         //  ��� �����, ��� ����������
    RequestMethod: string;    //  ��� �������: GET, POST, PUT, HEAD � ��.
    PostType: TPostType;      //  ������ �������� ������� � ����� ���������: ptNone - ��� ����; ptQuery - ������ ��� � GET �������; ptHeaders - ������������ ��� ��������� ��� ���������
    PostQuery: string;        //  ������ POST � PUT �������
    PostHeaders: TStringList; //  POST-������ � ���� ����������, �����, ��������, ��� �������� ����� �� ������ ����� �����. ������������ ���������� ������� � RFC 1867
    Referer: string;          //  ������ �� Referer
    Proxy: string;            //  ����� ������-�������
    ProxyBypass: string;      //  ������, ��� ������� �� ����� ������������ ������-������
    ProxyUserName: string;    //  ��� ������������ ��� ������
    ProxyPassword: string;    //  ������ ��� ������
    InternetAccessType: Cardinal;//��� �������: Direct, Preconfig, Proxy, PreconfigWithNoAutoProxy
    ReportLevel: TMsgTypes;   //  ������� ��������� ����������
    LoadFrom: Cardinal;       //  ��������� ������� ��� ����������, ����
    LoadCount: Cardinal;      //  ���������� ���������� ������, ����
    TypeOfData: TTypeOfData;  //  ��� �����������/������������ ������ (����, ������)
    SpeedLimit:Cardinal;      //  ����������� ��������, ����/�
    RepeatOnError: boolean;   //  ��������� ������� ��� ������ �����/�������
    RepeatCount: byte;        //  ���������� �������� ������� (0 - ����������)
    RepeatTimeout: Cardinal;  //  �������, ����� �������� ����� ������ ������� (��)
    AutoFileName: boolean;    //  �������� ��� ����� �������������
    WriteMethod: TWriteMethod;//  ����� ������ � ����
    BufferSize: Cardinal;     //  ������ ������

    UploadingString: string;  //  ����������� ������
    UploadingStream: TStream; //  ������ �� ����������� �����
    Downloading: boolean;     //  ��� True - ����� ���������� DownloadData, ��� False - UploadData

    FtpThroughHttpProxy: boolean;//��� True - ���������/�������� ������ ����� FTP ����� ������������� � ������� InternetOpenUrl, ��� ������������� � Http-������
    FtpPassive: boolean;      //  ��� True - ����� �������������� ��������� ����� ���������� � FTP
  end;

 //====��������� �������� �� ����������====
  //������
  TProxy = record
    Proxy: string;
    UserName: string;
    Password: string;
    Bypass: string;
  end;
  //��������� �������
  TRequestHeaders = record
    AcceptTypes: string;
    Referer: string;
    UserAgent: string;
  end;
  //��������� ����������
  TConnectionParams = record
    Url: string;
    UserName: string;
    Password: string;
  end;
  //��������� �������� POST-�������
  TPostParams = record
    PostType: TPostType;
    Query: string;
    Headers: TStringList;
  end;
  //��������� ���������� � FTP
  TFtpParams = record
    FtpThroghHttpProxy: boolean;
    Passive: boolean;
  end;
  //========================================

  //��������� Url: <�����>://<�����>:<������>@<����>:<����>/<Url-����>
  TUrlStructure = record
    Scheme: string;        //�����
    NumScheme: TInternetScheme;//����� �����
    UserName: string;      //�����
    Password: string;      //������
    Host: string;          //����
    Port: INTERNET_PORT;   //����
    UrlPath: string;       //Url-����
    ExtraInfo: string;     //���. ����. (��������, ������ GET-�������)
  end;

//===== TDownloadThread =========================
  TDownloadThread = class(TThread)
  private
    FTParameters: TParameters;  //  ��������� ����������
    FTMessageType: TMsgTypes;   //  ��� ����������� ���������
    FTMessage: string;          //  ����� ����������� ���������
    FTRecivedString: string;    //  �������� ������
    FTRecivedStream: TMemoryStream; //�������� ����� ������
    FTOnGiveMessage: TOnGiveMessage;//������� ��������� ���������
    FTDataSize: Cardinal;       //  ������ ���������� ������, ����
    FTNeedDataSize: Cardinal;   //  ������ ��������� ������, ����
    FTBytesReaded: Cardinal;    //  ���������� ����������� ����
    FTResult: boolean;          //  ��������� (�����/�������)
    FTOwnerHandle: HWND;        //  ����� ����������-��������� (����� ��� ������ InternetErrorDlg)
    FTUrlStructure: TUrlStructure;//��������� Url
    FTCurrentTime: int64;       //  ����� ������� �������� ��������/��������� ������
    FTUploadingStream: TMemoryStream;//����� ������ ��� ������� �� ������
    FTUseOpenUrl: boolean;      //  ��� True - ����� ������ ����� ������������� ��� ������ InternetOpenUrl
    hSession: HINTERNET;        // \
    hConnect: HINTERNET;        //  ��������� �� ������
    hRequest: HINTERNET;        // /
    LastError: Cardinal;        //  ��� ��������� ������
    Freq: int64;                //  �������, ���������� ��� ����������� �������
    StrHeaders: string;         // \���������, ������ ���� ���������� ���������
    StrOptional: string;        // /����� ��������� ������
    procedure GetMessage(FormatMsg: string; Args: array of TVarRec; MsgTypes: TMsgTypes; Error: boolean);
    procedure UpdateMessage;    //  ��������� ��������� (����� ��� �������������)
    function GetLastResponseInfo(var Error: Cardinal): string;//��������� �������������� ������ ��� ������
    function GetTime: int64;    //  ����������� ������� ��� ���������� �������� ����������
    function GetTimeDiff(StartTime, FinishTime: int64): Cardinal;//���������� �������� ����� ����� ���������� �������, ��
    procedure Delay(FromTime: int64; Delay: Cardinal);//�������� �� �������� ����� (��)
    function SetFileSize(const FileName: string; NewSize: Cardinal; CheckFile: boolean): boolean;//������� �������������� ������� �����
    function WriteFile(const FileName: string; Buf: PChar; BufLength: Cardinal; var WritePosition: Cardinal): boolean;//������� ������ �����
    function ReadFile(const FileName: string; out Buf: PChar; BufLength: Cardinal; ReadPosition: Cardinal): Cardinal; //������� ������ �����
    function GetSpeed(Bytes: Cardinal; PrevTime, CurrTime: int64): Cardinal;//������� ����������� �������� ����������, ����/�
    function ParseUrl(const Url: String; out UrlStructure: TUrlStructure): boolean;//������� �������� Url
    procedure SetLoadParameters;//  �������� � ��������� ���������� ������� ������
    function GetStatusCode(var StatusCode: Cardinal): boolean;//��������� ���� ������ �������
    function GetQueryInfo(dwInfoLevel: Cardinal): string;//������� ��������� ���������� �� �������
    function GetQueryOptions(dwInfoLevel: Cardinal): string;//��������� �������� ���������� ��������-����������
    function GetDataSize: Cardinal;  // ������� ��������� ������� ������
    function GetHandleType: Cardinal;// ������� ��������� ���� ������������� ������
    function GetFileName: string;    // ������� ��������� ����� �����
    function GetInetData(Buffer: Pointer; SizeOfBuffer: Cardinal; var BufferLen: Cardinal; var NumOfRepeat: byte): byte;//������� ��������� ������ ������ �� �����
    procedure GetHeaders(out Headers: PChar; out Optional: PChar);//��������� ����������� ���������� �� PostHeaders
    function InetConnect(Flags: Cardinal): boolean;//��������� ���������� � ����������
    function InetOpen(Flags: Cardinal): boolean;//�������� ������
    function InetOpenUrl(Flags: Cardinal): boolean;//�������� ������ � �������� ������� � �������������� InternetOpenUrl
    function SetProxyAuth(var StatusCode: Cardinal): boolean;//��������� ����������� �� ������-�������
    function GetErrorDlg(var StatusCode: Cardinal; Auth: boolean): boolean;//��������� ���� ������� ��� ��������� ������(��������� �����������, ���� ������)
    function InetReadFile: boolean;  // ������ ������ �� ���������
    function InetWriteFile: boolean; // ������ ������ �� ������
    function OpenRequest(Flags: Cardinal): boolean;//�������� �������
    function FtpFindFile(Flags:Cardinal; var FtpFile: TWin32FindData):boolean;//����� ����� �� ftp-�������
    function FtpSendCommand(const FtpCommandStr: string; var Ansver: string): boolean;//�������� ��������� ftp-�������
    function FtpSendingCommand: boolean;//�������� ���� �������������� ������ ftp
    function FtpSetCurrentDir(FtpFile: TWin32FindData): boolean;//��������� ������� ���������� �� ftp-�������
    function FtpOpen(Flags, Access: Cardinal): boolean;//�������� ftp-�����
    function SendingRequest: boolean;// �������� ������� � ������������ ������ ��������
    function SendRequest: boolean;   // ������� �������� �������
    function SendRequestEx: boolean; // ������� ������������ ������� (��� ������� ������ ������� PUT)
    function HttpDownload: boolean;  // ��������� ������ �� �����
    function HttpUpload: boolean;    // �������� ������ �� ������
    function FtpDownload: boolean;   // ��������� ������ � ftp-�������
    function FtpUpload: boolean;     // �������� ������ �� ftp-������
    function InetDownload: boolean;  // ��������� ������ ��� ������ InternetOpenUrl
    procedure CloseHandles;          // �������� ������� ��������-������
  protected
    procedure Execute; override;     // ���������� ������
  public
    constructor Create(const AParameters: TParameters; AOnGiveMessage: TOnGiveMessage; AOwnerHandle: HWND);
    destructor Destroy; override;
  end;
//===============================================

//===== TInetDownloader =========================
  TInetDownloader = class(TComponent)
  private
    FAcceptTypes: string;                       //  ����������� ���� ���������� ������
    FUserAgent: string;                         //  User Agent
    FUrl: string;                               //  Url �����, ������� ����� ��������
    FAuthUserName: string;                      //  ��� ������������ ��� Autentification: Basic
    FAuthPassword: string;                      //  ������ ��� Autentification: Basic
    FFileName: string;                          //  ��� �����, ��� ���������� ��� ��� �������� �� ������
    FRequestMethod: ShortString;                //  ��� �������
    FPostType: TPostType;                       //  ������ �������� POST/Custom �������
    FPostQuery: string;                         //  ������ POST/Custom �������
    FPostHeaders: TStringList;                  //  POST/Custom-������ � ���� ����������
    FReferer: string;                           //  ������ �� Referer
    FProxy: string;                             //  ����� ������-�������
    FProxyBypass: string;                       //  ������, ��� ������� �� ����� ������������ ������-������
    FProxyUserName: string;                     //  ��� ������������ ��� ������
    FProxyPassword: string;                     //  ������ ��� ������
    FInternetAccessType: TInternetAccessType;   //  ��� �������
    FReportLevel: TMsgTypes;                    //  ������� ��������� ����������
    FLoadFrom: Cardinal;                        //  ��������� ������� ��� ����������/�������, ����
    FLoadCount: Cardinal;                       //  ���������� ����������/������������ ������, ����
    FAutoFileName: boolean;                     //  ������������� ���������� ��� ����� �� Url
    FWaitOnWorkEnd: boolean;                    //  ������� ���������� ���������� ������ (!!!)� ���������� ���������� ����������� ������ ���� TRUE ����� ����� �� ����� ����������(!!!)
    FShowErrorDlg: boolean;                     //  ���������� InternetErrorDlg (������� ��� ����� ������ � �����������, ��� � IE)(� ���������� ���������� �� ������������)
    FRepeatOnError: boolean;                    //  ��������� ������� ��� ������ �����/�������
    FRepeatCount: byte;                         //  ���������� �������� �������
    FRepeatTimeout: Cardinal;                   //  �������, ����� �������� ����� ������ �������, ��
    FWriteMethod: TWriteMethod;                 //  ����� ������ � ����
    FBufferSize: Cardinal;                      //  ������ ������
    FSpeedLimit:Cardinal;                       //  ����������� ��������, ����/�
    FOnGiveMessage: TOnGiveMessage;             //  ������� ��������� ����������� ���������
    FOnDownloadFileDone: TOnDownloadFileDone;   //  ������� ��������� ���������� ���������� �����
    FOnDownloadStringDone: TOnDownloadStringDone;// ������� ��������� ���������� ��������� ������
    FOnDownloadStreamDone: TOnDownloadStreamDone;// ������� ��������� ���������� ��������� ������
    FOnUploadDone: TOnUploadDone;               //  ������� ��������� ���������� �������� ������
    FTypeOfData: TTypeOfData;                   //  ��� �������� ������ (����, ������, �����)
    FDownloadThread: TDownloadThread;           //  ��������� ������ ��������� ������ �� �����
    FThreadsList: TThreadList;                  //  ������ ���������� �������

    FUploadingString: string;                   //  ������������ ������
    FUploadingStream: TStream;                  //  ������������ �����
    FDownloading: boolean;                      //  ���������� ��� ��������: True - ���������� ������, False - ������� ������ �� ������

    FFtpThroughHttpProxy: boolean;              //  ������ � FTP ����� HTTP ������-������
    FFtpPassive: boolean;                       //  ������������ ��������� ����� ������ FTP

    procedure SetUrl(const Value: string);      //  ��������� ����� �������� Url
    function  GetRequestMethod: TRequestMethod; //  ������� ������ �������� RequestMethod
    procedure SetRequestMethod(const Value: TRequestMethod);//��������� ����� �������� RequestMethod
    procedure SetBufferSize(const Value: Cardinal);//���� ������� ������ ����������� ������
    procedure SetPostHeaders(const Value: TStringList);//���� PostHeaders
    function  GetWininetVersion: string;        //  ��������� ������ Wininet
    function  GetLocalIP: string;               //  ��������� ������ ��������� IP

    procedure StartThread;                      //  ������ ������ ����������
    procedure ThreadDone(Sender: TObject);      //  ���������� ���������� ���������� ������
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure DownloadFile;                     //  ��������� ������ � ���� �����
    procedure DownloadString;                   //  ��������� ������ � ���� ������
    procedure DownloadStream;                   //  ��������� ������ � ���� ������
    procedure UploadFile;                       //  ������� ����� �� ������
    procedure UploadString(const Str: string);  //  ������� ������ � ���� ������ �� ������
    procedure UploadStream(const Stream: TStream);//������� ������ � ���� ������ �� ������
    procedure Abort; overload;                  //  ������ ���������� ������
    procedure Abort(Index: Integer); overload;  //  ������ ���������� ������ �� ��� ������� � ������ ThreadsList

    function SetCustomRequestMethod(const Value: ShortString): boolean;//���� ����������������� ���� �������
    function GetMaxConnsPerServer(out MaxConnsPer1_0Server, MaxConnsPerServer: Int64): boolean;//��������� ������������ �������� ������������� ���������� ���������� � ����� ��������
    function SetMaxConnsPerServer(const MaxConnsPer1_0Server, MaxConnsPerServer: Cardinal): boolean;//��������� ������������ �������� ������������� ���������� ���������� � ����� ��������

    property ThreadsList: TThreadList read FThreadsList;
  published
    //  == �������� ==
    property Url: string read FUrl write SetUrl;
    property FileName: string read FFileName write FFileName;
    property AuthUserName: string read FAuthUserName write FAuthUserName;
    property AuthPassword: string read FAuthPassword write FAuthPassword;
    property InternetAccessType: TInternetAccessType read FInternetAccessType write FInternetAccessType;
    property Proxy: string read FProxy write FProxy;
    property ProxyUserName: string read FProxyUserName write FProxyUserName;
    property ProxyPassword: string read FProxyPassword write FProxyPassword;
    property ProxyBypass: string read FProxyBypass write FProxyBypass;
    property FtpThroughHttpProxy: boolean read FFtpThroughHttpProxy write FFtpThroughHttpProxy
      default False;
    property FtpPassive: boolean read FFtpPassive write FFtpPassive
      default False;
    property RequestMethod: TRequestMethod read GetRequestMethod write SetRequestMethod;
    property PostType: TPostType read FPostType write FPostType;
    property PostQuery: string read FPostQuery write FPostQuery;
    property PostHeaders: TStringList read FPostHeaders write SetPostHeaders;
    property LoadFrom: Cardinal read FLoadFrom write FLoadFrom
      default 0;
    property LoadCount: Cardinal read FLoadCount write FLoadCount
      default 0;
    property SpeedLimit: Cardinal read FSpeedLimit write FSpeedLimit
      default 0;
    property BufferSize: Cardinal read FBufferSize write SetBufferSize
      default 1024;
    property WriteMethod: TWriteMethod read FWriteMethod write FWriteMethod;
    property AcceptTypes: string read FAcceptTypes write FAcceptTypes;
    property UserAgent: string read FUserAgent write FUserAgent;
    property Referer: string read FReferer write FReferer;
    property AutoFileName: boolean read FAutoFileName write FAutoFileName
      default False;
    property ShowErrorDlg: boolean read FShowErrorDlg write FShowErrorDlg
      default True;
    property WaitOnWorkEnd: boolean read FWaitOnWorkEnd write FWaitOnWorkEnd
      default False;
    property RepeatOnError: boolean read FRepeatOnError write FRepeatOnError
      default False;
    property RepeatCount: byte read FRepeatCount write FRepeatCount
      default 3;
    property RepeatTimeout: Cardinal read FRepeatTimeout write FRepeatTimeout
      default 5;
    property ReportLevel: TMsgTypes read FReportLevel write FReportLevel;

    property WininetVersion: string read GetWininetVersion;
    property LocalIP: string read GetLocalIp;
    //  == ������� ==
    property OnGiveMessage: TOnGiveMessage read FOnGiveMessage write FOnGiveMessage;
    property OnDownloadFileDone: TOnDownloadFileDone read FOnDownloadFileDone write FOnDownloadFileDone;
    property OnDownloadStringDone: TOnDownloadStringDone read FOnDownloadStringDone write FOnDownloadStringDone;
    property OnDownloadStreamDone: TOnDownloadStreamDone read FOnDownloadStreamDone write FOnDownloadStreamDone;
    property OnUploadDone: TOnUploadDone read FOnUploadDone write FOnUploadDone;
  end;
//===============================================

procedure Register;

implementation

// ����������� ���������� �� ������� 'Samples'
procedure Register;
begin
  RegisterComponents('Samples', [TInetDownloader]);
end;

//==========================================================
// TInetDownloader
//==========================================================
constructor TInetDownloader.Create(aOwner: TComponent);
begin
  //�������� ����������� ������ (aOwner - �������� ����������)
  inherited Create(aOwner);
  //��������� ��������� ���������� ����������
  FUserAgent := 'Mozilla/4.0 (compatible; InetDownloader)';
  FAcceptTypes := '*/*';
  FReportLevel := [mOk, mError, mInfo, mResult, mMessage, mProgress, mDataSize, mBytesReaded, mSpeed];
  FLoadFrom := 0;
  FLoadCount := 0;
  FAutoFileName := False;
  FShowErrorDlg := True;
  FRepeatOnError := False;
  FFtpThroughHttpProxy := False;
  FFtpPassive := False;
  FRepeatCount := 3;
  FRepeatTimeout := 5000;
  FSpeedLimit := 0;
  FBufferSize := 1024;
  FRequestMethod := 'GET';
  FPostType := ptNone;
  FInternetAccessType := atPreconfig;
  FWriteMethod := wmRewrite;
  if IsConsole then     //��� ����������� ����������
    FWaitOnWorkEnd := True //�������� WaitOnWorkEnd ������ ���� True
  else
    FWaitOnWorkEnd := False;
  //������������� � ���������� ������ ������ � PostHeaders
  FPostHeaders := TStringList.Create;
  FPostHeaders.Add('Content-type: multipart/form-data, boundary=AaB03x542d');
  //�������������� ������ ������� (False - ��������, ��� ������ �� ����� ��������� ���������� �������� ��� ��������� ��������)
  FThreadsList := TThreadList.Create(False);
end;

destructor TInetDownloader.Destroy;
begin
  //������� ��������� ��������� ��������� (���� Access Violation �� �����������)
  FOnGiveMessage        := nil;
  FOnDownloadFileDone   := nil;
  FOnDownloadStringDone := nil;
  FOnDownloadStreamDone := nil;
  //����������� ������, ������� PostHeaders
  FPostHeaders.Free;
  //�������� ���������� ���� ���������� �������
  while FThreadsList.Count <> 0 do
    Abort;
  //����������� ������, ������� ������� �������
  FThreadsList.Free;
  //�������� ���������� ������
  inherited Destroy;
end;

//  ��������� ����� �������� Url
procedure TInetDownloader.SetUrl(const Value: string);
{Value - ����������� ��������}
begin
  //���� ���� ���� ������ ��� �������� ���������
  if (Value <> '') and (Pos('://', Value) = 0) then
    FUrl := IIF(Pos('ftp.', LowerCase(Value)) = 1,//���� ������ ���������� � 'ftp.'
                'ftp://' + Value,  //�������, ��� �������� 'ftp'
                'http://' + Value) //����� �������, ��� �������� 'http'
  else
    FUrl := Value;
end;

//������ �������� RequestMethod
function TInetDownloader.GetRequestMethod: TRequestMethod;
begin
  if FRequestMethod = 'GET' then
    Result := rmGet
  else if FRequestMethod = 'POST' then
    Result := rmPost
  else if FRequestMethod = 'HEAD' then
    Result := rmHead
  else
    Result := rmCustom
end;

//�������� ������ Wininet
function TInetDownloader.GetWininetVersion: string;
var
  RSize: Cardinal;
  Ver: INTERNET_VERSION_INFO;
begin
  //�������� �������� �������� � ������ ����� 'wininet.dll'
  Result := GetFileVersion(WININET_MODULE);
  //���� �� ������� - �������� �������� � ������� INTERNET_OPTION_VERSION
  if Result = '' then
    begin
      Result := 'N/A';
      RSize := SizeOf(INTERNET_VERSION_INFO);
      if InternetQueryOption(nil,
                             INTERNET_OPTION_VERSION,
                             @Ver,
                             RSize)
      then
        Result := IntToStr(Ver.dwMajorVersion) + '.' + IntToStr(Ver.dwMinorVersion);
    end;
end;

//�������� ������ ��������� IP �������
function TInetDownloader.GetLocalIP: string;
begin
  Result := Additional.GetLocalIP;
end;

//���� �������� RequestMethod
procedure TInetDownloader.SetRequestMethod(const Value: TRequestMethod);
{Value - ����������� ��������}
begin
  case Value of
    rmGet:    FRequestMethod := 'GET';
    rmPost:   FRequestMethod := 'POST';
    rmHead:   FRequestMethod := 'HEAD';
    rmCustom: FRequestMethod := '';
  end;
end;

//���� ����������������� �������� �������� RequestMethod
function TInetDownloader.SetCustomRequestMethod(const Value: ShortString): boolean;
begin
  if RequestMethod = rmCustom then
    begin
      FRequestMethod := Value;
      Result := True;
    end
  else
    Result := False;
end;

//������� �������� ������������� ���������� ���������� � ����� ��������
function TInetDownloader.GetMaxConnsPerServer(out MaxConnsPer1_0Server, MaxConnsPerServer: Int64): boolean;
{ MaxConnsPer1_0Server - ������������ ���������� ����������� � HTTP/1.0 �������
  MaxConnsPerServer - ������������ ���������� ����������� � �������
  Result - True, ���� �������� ��� ��������
}
var
  RSize: Cardinal;
begin
  RSize := 4;
  if not InternetQueryOption(nil,
                             INTERNET_OPTION_MAX_CONNS_PER_1_0_SERVER,
                             @MaxConnsPer1_0Server,
                             RSize)
  then
    MaxConnsPer1_0Server := -1;
  if not InternetQueryOption(nil,
                             INTERNET_OPTION_MAX_CONNS_PER_SERVER,
                             @MaxConnsPerServer,
                             RSize)
  then
    MaxConnsPerServer := -1;
  Result := (MaxConnsPer1_0Server <> -1) and (MaxConnsPerServer <> -1);
end;

//������������� �������� ������������� ���������� ���������� � ����� ��������
function TInetDownloader.SetMaxConnsPerServer(const MaxConnsPer1_0Server, MaxConnsPerServer: Cardinal): boolean;
var
  RSize: Cardinal;
begin
  RSize := 4;
  Result := (InternetSetOption(nil,
                              INTERNET_OPTION_MAX_CONNS_PER_1_0_SERVER,
                              @MaxConnsPer1_0Server,
                              RSize))
  and
           (InternetSetOption(nil,
                              INTERNET_OPTION_MAX_CONNS_PER_SERVER,
                              @MaxConnsPerServer,
                              RSize))
end;

//���� ������� ������ ����������� ������
procedure TInetDownloader.SetBufferSize(const Value: Cardinal);
{Value - ����������� ��������}
begin
    FBufferSize := FormatNumber(Value); //����� ������ ���� ������, ������� 16: 256, 512, 768, 1024...
end;

//���� PostHeaders
procedure TInetDownloader.SetPostHeaders(const Value: TStringList);
{Value - ����������� ��������}
begin
  FPostHeaders.Assign(Value);
end;

//�������� ��������� ��� ��������� ������ �� �����
procedure TInetDownloader.DownloadFile;
begin
  FDownloading := True;
  //���� �� ��������� ��� ����� � �� ����� ����� AutoFileName
  if (FFileName = '') and not FAutoFileName then
    begin
      //������� ��������� �� ������ � �������
      if (Assigned(FOnGiveMessage)) then
        if ([mResult, mError] <= FReportLevel) then
          FOnGiveMessage(Self, [mResult, mError], MSG_NOT_FILL_FILENAME);
      Exit;
    end;
  FTypeOfData := odFile;//��� ���������� ������ - ����
  StartThread; //��������� ����� ����������
end;

//��������� ��������� ������
procedure TInetDownloader.DownloadString;
begin
  FDownloading := True;
  FTypeOfData := odString;//��� ���������� ������ - ������
  StartThread; //��������� ����� ����������
end;

//��������� ��������� ������
procedure TInetDownloader.DownloadStream;
begin
  FDownloading := True;
  FTypeOfData := odStream;//��� ���������� ������ - �����
  StartThread; //��������� ����� ����������
end;

//��������� ������� ����� �� ������
procedure TInetDownloader.UploadFile;
begin
  FDownloading := False;
  FTypeOfData := odFile;//��� ������ - ����
  StartThread; //��������� ����� ����������
end;

//��������� ������� ������ � ���� ������ �� ������
procedure TInetDownloader.UploadString(const Str: string);
begin
  FDownloading := False;
  FTypeOfData := odString;//��� ������ - ������
  FUploadingString := Str;
  StartThread; //��������� ����� ����������
end;

//��������� ������� ������ � ���� ������ �� ������
procedure TInetDownloader.UploadStream(const Stream: TStream);
begin
  FDownloading := False;
  FTypeOfData := odStream;//��� ������ - �����
  FUploadingStream := Stream;
  StartThread; //��������� ����� ����������
end;

//������ ������ ����������
procedure TInetDownloader.StartThread;
var Parameters: TParameters; //����� ���������� ��� ����������
    Msg: TMsg;               //������������� ��� ����������� � ������ Application.ProcessMessage
    Handle: HWND;            //����� �������, �� ������� ������ ��������� InternetErrorDlg
begin
  //���� ��� �� �������
  if FUrl = '' then
    begin
      //������� ��������� �� ������ � �������
      if (Assigned(FOnGiveMessage)) then
        if ([mResult, mError] <= FReportLevel) then
          FOnGiveMessage(Self, [mResult, mError], MSG_NOT_FILL_URL);
      Exit;
    end;

  //���� �� ���������� ����� ������
  if ((FTypeOfData <> odStream) or FDownloading) then
    FUploadingStream := nil;//������� ������ �� �����

//====== ��������� ��������� ���������� =============
  with Parameters do begin
    case FInternetAccessType of
      atDirect:                   InternetAccessType := INTERNET_OPEN_TYPE_DIRECT;
      atPreconfig:                InternetAccessType := INTERNET_OPEN_TYPE_PRECONFIG;
      atProxy:                    InternetAccessType := INTERNET_OPEN_TYPE_PROXY;
      atPreconfigWithNoAutoProxy: InternetAccessType := INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY;
    else
      InternetAccessType := INTERNET_OPEN_TYPE_PRECONFIG;
    end;

    AcceptTypes := FAcceptTypes;
    UserAgent := FUserAgent;
    Url := FUrl;
    AuthUserName := FAuthUserName;
    AuthPassword := FAuthPassword;
    FileName := FFileName;
    PostType := FPostType;
    PostHeaders := FPostHeaders;
    PostQuery := FPostQuery;
    RequestMethod := FRequestMethod;
    Referer := FReferer;
    Proxy := FProxy;
    ProxyBypass := FProxyBypass;
    ProxyUserName := FProxyUserName;
    ProxyPassword := FProxyPassword;
    ReportLevel := FReportLevel;
    LoadFrom := FLoadFrom;
    LoadCount := FLoadCount;
    RepeatOnError := FRepeatOnError;
    RepeatCount := FRepeatCount;
    RepeatTimeout := FRepeatTimeout;
    AutoFileName  := FAutoFileName;
    TypeOfData := FTypeOfData;
    WriteMethod := FWriteMethod;
    BufferSize := FBufferSize;
    SpeedLimit := FSpeedLimit;

    UploadingString := FUploadingString;
    UploadingStream := FUploadingStream;
    Downloading := FDownloading;
    FtpThroughHttpProxy := FFtpThroughHttpProxy;
    FtpPassive := FFtpPassive;            
  end;
//===================================================
   if FShowErrorDlg then  //���� ����� ����� ShowErrorDlg
     begin
       if IsConsole then  //���� ���������� ����������
         Handle := GetDesktopWindow //�� ����������� ����� �������� �����
       else
         Handle := FindWindow(PChar(String(GetOwner.ClassName)), nil);//����� ���������� ���������� ���� ����� �����, �� ������� ����� ���������
     end
   else //���� �� ����� ����� ShowErrorDlg
     Handle := 0; //����������� �������������� ����� (0)
  //������� ��������� ������
  FDownloadThread := TDownloadThread.Create(Parameters,     //��������� ����������
                                            FOnGiveMessage, //��������� ��������� ��������� ������
                                            Handle);        //����� ����� ��� ������ InternetErrorDlg
  //����������� ��� ���������� ���������� ���������� ������
  FDownloadThread.OnTerminate := ThreadDone;
  //������� ��������� ����� � ������
  FThreadsList.Add(FDownloadThread);

  if FWaitOnWorkEnd then //���� ����� ����� "WaitOnWorkEnd"
    begin
      if IsConsole then //���� ������������ � ���������� ����������
        begin
          FDownloadThread.WaitFor;    //����� ����� ������ � ���� �� ����������
          FreeAndNil(FDownloadThread);//����������� ������, ���������� ������� � ������� ������ �� ��������� ������
        end
      else //���� ���������� �������
        while FThreadsList.Count <> 0 do //���� � ��� ���� ������
          //===����� ������ Application.ProcessMessage====
          while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
            if Msg.message = WM_QUIT then
              begin
                PostQuitMessage(Msg.wParam);
                Exit;
              end
            else
              begin
                TranslateMessage(Msg);
                DispatchMessage(Msg);
              end
          //==============================================
    end;
end;

//��������� ��������� ���������� ������
procedure TInetDownloader.ThreadDone(Sender: TObject);
begin
  with (Sender as TDownloadThread) do
    begin
      if FTResult then //���� ��������� - �����
        begin
          //���������� ��������� �� �������� ����������
          FTMessageType := [mResult, mOk];
          FTMessage := IIF(FDownloading,
                           MSG_DOWNOLOADING_DATA_OK,
                           MSG_UPLOADING_DATA_OK);
        end
      else //�����
        begin
          //���������� ��������� �� ������
          FTMessageType := [mResult, mError];
          FTMessage := IIF(FDownloading,
                           MSG_DOWNOLOADING_DATA_ERROR,
                           MSG_UPLOADING_DATA_ERROR);
        end;
      //���������� ���������
       if Assigned(FOnGiveMessage) and (FTMessageType <= FTParameters.ReportLevel) then
         //������������� �� ���������, �.�. ����� ��� ��������, ��������� ������������ ��������
         FOnGiveMessage(Sender, FTMessageType, FTMessage);
      if FTParameters.Downloading then
        case FTParameters.TypeOfData of
          odString: //���� ��� ���������� ������ - ������
            if Assigned(FOnDownloadStringDone) then
              //������� ��������� ��������� ���������� ��������� ������
              FOnDownloadStringDone(Sender, FTRecivedString, FTNeedDataSize, FTBytesReaded, FTResult);
          odFile:  //���� ��� ���������� ������ - ����
            if Assigned(FOnDownloadFileDone) then
              //������� ��������� ��������� ���������� ��������� �����
              FOnDownloadFileDone(Sender, FTParameters.FileName, FTNeedDataSize, FTBytesReaded, FTResult);
          odStream: //���� ��� ���������� ������ - �����
            if Assigned(FOnDownloadStreamDone) then
              begin
                //������� ��������� ��������� ���������� ��������� ������
                FOnDownloadStreamDone(Sender, FTRecivedStream, FTNeedDataSize, FTBytesReaded, FTResult);
              end
        end
      else
        if Assigned(FOnUploadDone) then
          begin
            //������� ��������� ��������� ���������� �������� ������
            FOnUploadDone(Sender, FTParameters.Url, FTNeedDataSize, FTBytesReaded, FTResult);
          end
    end;
  //������� ����� �� ������
  FThreadsList.Remove(TThread(Sender));
  //������� ������ �� ��������� ������
  FDownloadThread := nil;
end;

//��������� ������ ���������� ���������� ����������� ������
procedure TInetDownloader.Abort;
begin
  //���� ���� ���������� ������
  if FThreadsList.Count > 0 then
    //�� ��������� Abort � ���������� Index - ������ ���������� ����������� ������
    Abort(FThreadsList.Count - 1);
end;

//��������� ������ ���������� ������ �� ��� ������� � ������ �������
procedure TInetDownloader.Abort(Index: Integer);
var
  ADownloadThread: TDownloadThread;  //��������� ������
begin
  //�������� ������ �� ��������� ������ �� ������ �� ��� �������
  ADownloadThread := TDownloadThread(FThreadsList[Index]);
  //������� ���������� ����� �� ������
  FThreadsList.Delete(Index);
  //���� ��������� ������ ����������
  if Assigned(ADownloadThread) then
    with ADownloadThread do
      begin
        //���������� ������������� �������� "�������"
        FTResult := False;
        //****������������ ���������***
        FTMessageType := [mResult, mError];
        FTMessage := MSG_ABORT;
        if Assigned(FOnGiveMessage) and (FTMessageType <= FTParameters.ReportLevel) then
          //�.�. ����� ����� ��������, �� ��������� ������������
          //�� ��������� �������������, � ��������
          FOnGiveMessage(ADownloadThread, FTMessageType, FTMessage);
        //*****************************
        //��������� ���������� ������
        CloseHandles;
        TerminateThread(Handle, 0);//(!!!)����� ����������� �� ��� �������(!!!)
        //������������ ������, ���������� ������� � ������� ������ �� ��������� ������
        FreeAndNil(ADownloadThread);
      end;
end;

//==========================================================
// TDownloadThread
//==========================================================
constructor TDownloadThread.Create;
begin
  inherited Create(True);           // �������� ������ � ��������� Suspensed
  Priority        := tpLower;       // ��������� ������ - ������
  FreeOnTerminate := not IsConsole; // ��� �������� ���������� - True, ��� ������� - False, �.�. ������ ��������� ����)
  FTResult        := False;         // ������������� ��������� - �������
  FTParameters    := AParameters;   // �������� ���������,
  FTRecivedString := '';            // ������� �������� ������
  if FTParameters.TypeOfData = odStream then
    FTRecivedStream := TMemoryStream.Create;//������� ����� ������ ��� ����������
  if Assigned(FTParameters.UploadingStream) then //���� ����� ������ ���������
    begin
      FTUploadingStream := TMemoryStream.Create;//������� ����� ������ ��� �������� �� ������
      FTUploadingStream.LoadFromStream(FTParameters.UploadingStream);//��������� ���
    end;
  FTOnGiveMessage := AOnGiveMessage;// ��������� ��������� ���������
  FTOwnerHandle   := AOwnerHandle;  // � ����� ������������� ����
  FTBytesReaded   := 0;             // \
  FTCurrentTime   := 0;             //   �������� ��������� ��������
  FTUseOpenUrl    := False;         // /
  Resume;                           // ������� ����� �� ��������� Suspensed
end;

destructor TDownloadThread.Destroy;
begin
  //������� ��������� ��������� (���� Access Violation �� �����������)
  FTOnGiveMessage := nil;
  //������� ������ ������
  FreeAndNil(FTRecivedStream);
  FreeAndNil(FTUploadingStream);
  //��������� �������� ������
  CloseHandles;
  //�������� ���������� ������
  inherited Destroy;
end;

//��������� ������������� � ���������� ���������
procedure TDownloadThread.UpdateMessage;
begin
  if Assigned(FTOnGiveMessage) then
    FTOnGiveMessage(Self, FTMessageType, FTMessage)
end;

//��������� ���������� ������
//����������� �������������, ����� ����� ��������� � ������� ���������
procedure TDownloadThread.Execute;
begin
  //������������� ������� ������� (���� ��������)
  if not QueryPerformanceFrequency(Freq) then
    Freq := 0;
  //��������� ������� ���
  if ParseUrl(FTParameters.Url, FTUrlStructure) then
    begin
      if FTUrlStructure.UserName <> '' then //���� � ��� ��� ������ �����
        begin //�� �������� AuthUserName � AuthPassword �� �����/������, ���������� �� ���
          FTParameters.AuthUserName := FTUrlStructure.UserName;
          FTParameters.AuthPassword := FTUrlStructure.Password;
        end;
      if not ((FTUrlStructure.NumScheme = INTERNET_SCHEME_HTTP) or
             (FTUrlStructure.NumScheme = INTERNET_SCHEME_HTTPS) or
             (FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP))
         or  (FTParameters.FtpThroughHttpProxy and
             (FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP))
         then
           FTUseOpenUrl := True;

      if FTUseOpenUrl then
          begin
            if FTParameters.Downloading then
              FTResult := InetDownload
            else begin
              GetMessage(MSG_DOWNLOAD_ONLY, [],
                         [mMessage, mError], False);
              FTResult := False;
            end;
          end
      else if FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP then
        begin
          if FTParameters.Downloading then
            FTResult := FtpDownload
          else
            FTResult := FtpUpload;
        end
      else
        begin
          if FTParameters.Downloading then
            FTResult := HttpDownload
          else
            FTResult := HttpUpload;
        end;
    end;
end;

//��������� �������
function TDownloadThread.GetTime: int64;
var
 Tick: int64;
begin
  if (Freq <> 0) and QueryPerformanceCounter(Tick) then
    Result := Tick
  else
    Result := GetTickCount;
end;

//��������� ������� ����� ����� ���������� ������� � ��
function TDownloadThread.GetTimeDiff(StartTime, FinishTime: int64): Cardinal;
begin
  if Freq <> 0 then
    Result := Round(Abs(StartTime - FinishTime) * 1000 / Freq)
  else
    Result := Abs(StartTime - FinishTime);
end;

procedure TDownloadThread.Delay(FromTime: int64; Delay: Cardinal);
{FromTime - �����, �� �������� ����������� ��������
 Delay - ��������, ��
}
begin
  //������������ ������ ���� �� ����� Delay
  while Delay > GetTimeDiff(FromTime, GetTime) do ;
end;

//������� ������� �����
function TDownloadThread.SetFileSize(const FileName: string; NewSize: Cardinal; CheckFile: boolean): boolean;
{FileName - ��� �����
 Size - ��������������� ������
 CheckFile - �������� �� ������������ ��������
}
var
  F: TFileStream; //�������� �����
begin
  try
    //���� ���� ���������� - ������� ��� ������, ����� - �������
    if FileExists(FileName) then
      F := TFileStream.Create(FileName, fmOpenWrite or fmShareDenyNone)
    else
      F := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
    try
      //���� �������� �� �������� ��� ������ � ����� ������� �� ���������
      if not CheckFile or (F.Size <> NewSize) then
        begin
          F.Size := 0; //������� ���� �������� ������� (����� ��� ��������� ������ ������� ���� �������� �������� NULL'���)
          F.Size := NewSize; //���������� ����� ������ �����
        end;
      Result := True;
    finally
      F.Free;  //���������� �������
    end;
  except
    LastError := GetLastError;
    //**** � ������ ������ ������ ��������������
    GetMessage(MSG_DOWNLOAD_FILE_ERROR, [FTParameters.FileName],
               [mMessage, mError], True);
    //****
    Result := False;;
  end;
end;

//������ ������ ������ � ����
function TDownloadThread.WriteFile(const FileName: string; Buf: PChar; BufLength: Cardinal; var WritePosition: Cardinal): boolean;
{FileName - ��� ������������� �����
 Buf - ����� ������
 BufLength - ������ ������
 WritePosition - ������� ������ � ���� (���� -1 - �� ������������ � ����� �����)
}
var
  F: TFileStream; //�������� �����
begin
  try
    //���� ���� ���������� - ������� ��� ������, ����� - �������
    if FileExists(FileName) then
      F := TFileStream.Create(FileName, fmOpenWrite or fmShareDenyNone)
    else
      F := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
    try
      //���������� ������� ������
      F.Position := IIF(WritePosition = DWORD(-1), //���� WritePosition ����� -1
                        F.Size,                    //�� ������������� ��������� �� ����� �����
                        WritePosition);            //����� ��������� ��������� ������������ WritePosition
      F.Write(Buf^, BufLength);  //�������� ����� � ����
      if WritePosition <> DWORD(-1) then //���� WritePosition �� ����� -1
        Inc(WritePosition, BufLength);   //�� ��������� WritePosition �� ������ ���������� ������
      Result := True;
    finally
      F.Free;  //���������� �������
    end;
  except
    LastError := GetLastError;
    //**** � ������ ������ ������ ��������������
    GetMessage(MSG_DOWNLOAD_FILE_ERROR, [FTParameters.FileName],
               [mMessage, mError], True);
    //****
    Result := False;
  end;
end;

//������ ����� � �����
function TDownloadThread.ReadFile(const FileName: string; out Buf: PChar; BufLength: Cardinal; ReadPosition: Cardinal): Cardinal;
{FileName - ��� ������������ �����
 Buf - ����� ������
 BufLength - ������ ������
 ReadPosition - ������� ������ �����
 Result - ������ ����������� ������, ����
}
var
  F: TFileStream; //�������� �����
begin
  Result := 0;
  try
    //������� ���� ��� ������
    F := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
      //���������� ������� ������
      F.Position := ReadPosition;
      Result := F.Read(Buf^, BufLength);  //������� ������ �� ����� � �����, ���������� ������ ��������� ������
    finally
      F.Free;  //���������� �������
    end;
  except
    LastError := GetLastError;
    //**** � ������ ������ ������ ��������������
    GetMessage(MSG_READ_FILE_ERROR, [FTParameters.FileName],
               [mMessage, mError], True);
    //****
  end;
end;

//��������� �������� ����������
function TDownloadThread.GetSpeed(Bytes: Cardinal; PrevTime, CurrTime: int64): Cardinal;
{ Bytes - ���������� ���������/������������ ������, ����
  PrevTime - ��������� �������� �������
  Result - �������� ����������, ����/�
}
var
  dTime: Cardinal;   //������ ������� ����� ������� � ��������� ��������, ��
  Shift: Cardinal;   //��������, ��� (��������� ��� ����������� ��������)
begin
  //�������� ������� ������� � ��
  dTime := GetTimeDiff(PrevTime, CurrTime);
  if dTime > 0 then
    Result := Round((Bytes / dTime * 1000))//���������� ��������
  else
    Result := 0;
  //���� ���������� ����� �������� � �������� ��� ���������
  if (FTParameters.SpeedLimit <> 0) and (Result > FTParameters.SpeedLimit) then
    begin
      //����������� ��������
      Shift := Round(dTime * ((Result / FTParameters.SpeedLimit) - 1) * 1000);
      //������� �������� �����
      Delay(CurrTime, Shift);
      //�������� ���������� ��������
      Result := GetSpeed(Bytes, PrevTime, CurrTime);
    end;
end;

//�������������� ��������� ��� ������
procedure TDownloadThread.GetMessage(FormatMsg: string; Args: array of TVarRec; MsgTypes: TMsgTypes; Error: boolean);
{Msg - ����� ���������
 MsgTypes - ��� ���������
}
var
  ErrMsg: string;
  ErrCode: Cardinal;
begin
  ErrCode := 0;
  if MsgTypes <= FTParameters.ReportLevel then //��������� ������������ ������ ��������� ����������
    begin
      FTMessageType := MsgTypes;               //������������� ��� ���������
      FTMessage := Format(FormatMsg, Args);    //������ ������ ���������
      if Error then
        begin
          if LastError = ERROR_INTERNET_EXTENDED_ERROR then
            ErrMsg := GetLastResponseInfo(ErrCode)
          else
            ErrMsg := WinInetErrorMessage(LastError);
          if ErrCode = 0 then
            ErrCode := LastError;
          FTMessage := FTMessage + Format(MSG_FORMAT_ERROR, [ErrMsg, ErrCode]);
        end;
      Synchronize(UpdateMessage);            //�������������� � ���������� ������ ���������
    end;
end;

//������� ��������� �������������� ���������� �� �������
function TDownloadThread.GetLastResponseInfo(var Error: Cardinal): string;
var
  RSize: Cardinal; //����� ��� ��������� �������
  PErrorInfo: PChar; //�������� ����������, ���������� �� �������
begin
  Result := ''; //������� ���������
  RSize := 0;   //������������� ������ ������ 0, ����� ��� ������ ������ HttpQueryInfo, � ���� ����� ������� ��������� ������
  InternetGetLastResponseInfo(Error,
                              PErrorInfo,
                              RSize); //������ � RSize ������������ ��������� ������
  if RSize > 0 then begin
    PErrorInfo := StrAlloc(RSize); //�������� ������ ������� �������
    try
      if InternetGetLastResponseInfo(Error,
                                     PErrorInfo, //������ � ���������� ������������ ���������� ����
                                     RSize)
      then begin
        //������� ���������� ������ �� ������������ �������� � �����
        while (RSize > 0) and (PErrorInfo[RSize - 1] in [#0..#32, '.']) do Dec(RSize);
        //������ �������� ������ ������� �������
        SetString(Result, PErrorInfo, RSize);
      end;
    finally
      StrDispose(PErrorInfo); //����������� ������, ���������� ��� ������
    end;
  end;
end;


// ��������� �������� Url
// <�����>://<�����>:<������>@<����>:<����>/<Url-����>
function TDownloadThread.ParseUrl(const Url: String; out UrlStructure: TUrlStructure): boolean;
var
  AUrlStructure: URL_COMPONENTS;//��������� ��������� Url
  Flags: Cardinal; //����� ��� �������� ������ Url � ���������
begin
  Result := False;
  //������������� �����
  Flags := 0;
  //������� ��������� �� �������� ������
  ZeroMemory(@AUrlStructure, SizeOf(AUrlStructure));
  ZeroMemory(@UrlStructure, SizeOf(UrlStructure));

  with AUrlStructure do begin
    //---������������� ��������� �������� ���������---
    dwStructSize := SizeOf(URL_COMPONENTS);
    lpszScheme := nil;
    dwSchemeLength := INTERNET_MAX_SCHEME_LENGTH;
    nScheme := INTERNET_SCHEME_DEFAULT;
    lpszHostName := nil;
    dwHostNameLength := INTERNET_MAX_HOST_NAME_LENGTH;
    nPort := INTERNET_INVALID_PORT_NUMBER;
    lpszUserName := nil;
    dwUserNameLength := INTERNET_MAX_USER_NAME_LENGTH;
    lpszPassword := nil;
    dwPasswordLength := INTERNET_MAX_PASSWORD_LENGTH;
    lpszUrlPath := nil;
    dwUrlPathLength := INTERNET_MAX_PATH_LENGTH;
    lpszExtraInfo := nil;
    dwExtraInfoLength := INTERNET_MAX_PATH_LENGTH;
    //------------

    //��������� ������ Url �� ������������
    if InternetCrackUrl(PChar(Url), Length(Url), Flags, AUrlStructure) then
      with UrlStructure do
        begin
          //---������� ���������� �������� � UrlStructure---
          SetString(Scheme, lpszScheme, dwSchemeLength);
          SetString(Host, lpszHostName, dwHostNameLength);
          SetString(UserName, lpszUserName, dwUserNameLength);
          SetString(Password, lpszPassword, dwPasswordLength);
          SetString(UrlPath, lpszUrlPath, dwUrlPathLength);
          SetString(ExtraInfo, lpszExtraInfo, dwExtraInfoLength);
          NumScheme := nScheme;
          Port := nPort;
          //------------

          Result := True;
        end
    else
      begin
        LastError := GetLastError;
        //***� ������ ������ ������ ��������������***
        GetMessage(MSG_URL_ERROR, [],
                   [mMessage, mError], True);
        //******
      end;
  end;
end;

procedure TDownloadThread.SetLoadParameters;
begin
  //���������� ��������� ����������
  if FTParameters.LoadCount = 0 then
    begin
      if FTParameters.LoadFrom <= FTDataSize then
        FTNeedDataSize := FTDataSize - FTParameters.LoadFrom
      else
        FTNeedDataSize := 0;
    end
  else
    begin
      //���� ������ ������ ��������� � ������������ �������� ���������� ������, ����������� ���������
      if FTParameters.LoadFrom + FTParameters.LoadCount > FTDataSize then
        begin
          if FTParameters.LoadFrom < FTDataSize then //���� ��������� ������� ������ ������ ��� ��������� ������
            //�� ��������� ���������� ��������� ������, �� ����������� ����������
            FTParameters.LoadCount := FTDataSize - FTParameters.LoadFrom
          else //�����, ������ 0
            FTParameters.LoadCount := 0;
        end;
        FTNeedDataSize := FTParameters.LoadCount;
    end;
end;

//��������� ���� ������ �������
function TDownloadThread.GetStatusCode(var StatusCode: Cardinal): boolean;
{hRequest - ����� �������, �� �������� ����� �������� ����
 StatusCode - ���������� ��� ������ �������
}
var
  RSize: Cardinal; //����� ��� ��������� �������
  dwIndex: Cardinal; //��� ����������� � HttpQueryInfo � �������� ����������������� ����������
begin
  RSize := 4;  //������ ���������� ������ (��� DWORD ������ �������� 4)
  dwIndex := 0;
  Result := HttpQueryInfo(hRequest,
                          HTTP_QUERY_STATUS_CODE or//�����: �������� ��� ������ �������
                          HTTP_QUERY_FLAG_NUMBER,  //� �������� ����
                          @StatusCode,             //��������� �� ����������, � ������� ��������� ���������
                          RSize,                   //������
                          dwIndex);                //����������������� ����������
end;

//������� ��������� ���������� �� �������
function TDownloadThread.GetQueryInfo(dwInfoLevel: Cardinal): string;
{dwInfoLevel - �����, ������������ ����� ���� ����� ��������
}
var
  RSize: Cardinal; //����� ��� ��������� �������
  PQueryInfo: PChar; //�������� ����������, ���������� �� �������
  dwIndex: Cardinal; //��� ����������� � HttpQueryInfo � �������� ����������������� ����������
begin
  Result := ''; //������� ���������
  RSize := 0;   //������������� ������ ������ 0, ����� ��� ������ ������ HttpQueryInfo, � ���� ����� ������� ��������� ������
  dwIndex := 0;
  HttpQueryInfo(hRequest,
                dwInfoLevel,
                PQueryInfo,
                RSize, //������ � RSize ������������ ��������� ������
                dwIndex);
  if RSize > 0 then begin
    PQueryInfo := StrAlloc(RSize); //�������� ������ ������� �������
    try
      if HttpQueryInfo(hRequest,
                       dwInfoLevel,
                       PQueryInfo, //������ � ���������� ������������ ���������� ����
                       RSize,
                       dwIndex)
      then begin
        //������� ���������� ������ �� ������������ �������� � �����
        while (RSize > 0) and (PQueryInfo[RSize - 1] in [#0..#32, '.']) do Dec(RSize);
        //������ �������� ������ ������� �������
        SetString(Result, PQueryInfo, RSize);
      end;
    finally
      StrDispose(PQueryInfo); //����������� ������, ���������� ��� ������
    end;
  end;
end;

//��������� �������� �� ����������
function TDownloadThread.GetQueryOptions(dwInfoLevel: Cardinal): string;
{dwInfoLevel - �����, ������������ ����� ���� ����� ��������
}
var
  RSize: Cardinal; //����� ��� ��������� �������
  PQueryOptions: PChar; //�������� ����������, ���������� �� �������
begin
  Result := ''; //������� ���������
  RSize := 0;   //������������� ������ ������ 0, ����� ��� ������ ������ HttpQueryInfo, � ���� ����� ������� ��������� ������
  InternetQueryOption(hRequest,
                      dwInfoLevel,
                      PQueryOptions,
                      RSize); //������ � RSize ������������ ��������� ������
  if RSize > 0 then begin
    PQueryOptions := StrAlloc(RSize); //�������� ������ ������� �������
    try
      if InternetQueryOption(hRequest,
                             dwInfoLevel,
                             PQueryOptions, //������ � ���������� ������������ ���������� ����
                             RSize)
      then begin
        //������� ���������� ������ �� ������������ �������� � �����
        while (RSize > 0) and (PQueryOptions[RSize - 1] in [#0..#32, '.']) do Dec(RSize);
        //������ �������� ������ ������� �������
        SetString(Result, PQueryOptions, RSize);
      end;
    finally
      StrDispose(PQueryOptions); //����������� ������, ���������� ��� ������
    end;
  end;
end;

//������� ��������� ������� ������
function TDownloadThread.GetDataSize: Cardinal;
{hRequest - ����� �������, �� �������� ����� �������� ����
}
var
  RSize: Cardinal; //����� ��� ��������� �������
  dwIndex: Cardinal; //��� ����������� � HttpQueryInfo � �������� ����������������� ����������
begin
  //�������� �������� ������ ����� ��������� � ��� �����
  Result := InternetSetFilePointer(hRequest,
                                   0,        //�������� - 0
                                   nil,
                                   FILE_END, //������������ ����� �����
                                   0);
  if Result = DWORD(-1) then //���� �� ����������
    begin
      Result := 0;
      RSize := 4;  //������ ���������� ������ (��� DWORD ������ �������� 4)
      dwIndex := 0;
      //�������� ���������� ������ ����� � ������� HttpQueryInfo
      HttpQueryInfo(hRequest,
                    HTTP_QUERY_CONTENT_LENGTH or //�����: �������� ������ �����������
                    HTTP_QUERY_FLAG_NUMBER,      //� �������� ����
                    @Result,
                    RSize,
                    dwIndex);
    end;
end;

//������� ��������� ���� ������
function TDownloadThread.GetHandleType: Cardinal;
{hConnect - ����� ����������, �� �������� ����� �������� ����
}
var
  dwRes: Cardinal; //��������� ����������
  RSize: Cardinal; //����� ��� ��������� �������
begin
  RSize := 4;
  if InternetQueryOption(hConnect,
                         INTERNET_OPTION_HANDLE_TYPE,
                         @dwRes,
                         RSize)
  then
    Result := dwRes
  else begin
      LastError := GetLastError;
      //**** ���� �� ������� ������� ���������� ������ ���������
      GetMessage('�������� ������', [],
                 [mMessage, mError], True);
    Result := 0;
    end;
end;

//������� ��������� ����� �����
function TDownloadThread.GetFileName: string;
{hRequest - ����� �������, �� �������� ����� �������� ����
}
var
  i: integer;
  tempStr: string;
begin
  Result := ''; //������� ���������
  //���� ��� ��������� HTTP ������
  if ((GetHandleType = INTERNET_HANDLE_TYPE_HTTP_REQUEST) or (GetHandleType = INTERNET_HANDLE_TYPE_CONNECT_HTTP)) then
    begin
      //�������� �������� ��� ����� � ������� HttpQueryInfo
      tempStr := GetQueryInfo(HTTP_QUERY_CONTENT_DISPOSITION);
      i := Pos('filename=', tempStr);
      if i <> 0 then //���� � ���������� ���������� ���������� ��� �����
        begin
          Delete(tempStr, 1, i + 8); //8 = (Length('filename=') - 1)
          i := Pos(';', tempStr);
          //�� ���������� ����������� ���
          if i <> 0 then
            Result := AnsiDequotedStr(Copy(tempStr, 1, i), '"')
          else
            Result := AnsiDequotedStr(Copy(tempStr, 1, Length(tempStr)), '"');
        end;
    end;

  if Result = '' then //���� �� ���
    begin
      //�������� ��� ����� �� Url
      if FTUrlStructure.UrlPath = '' then
        Result := FTUrlStructure.Host
      else
        begin
          tempStr := FTUrlStructure.UrlPath;
          if tempStr[Length(tempStr)] = '/' then
            SetLength(tempStr, Length(tempStr) - 1);
          i := LastDelimiter('/', tempStr);
          Result := Copy(tempStr, i + 1, Length(tempStr) - i);
          if Result = '' then
            Result := 'default.htm';
        end;

      //�������� ���� � ���� �����������
      tempStr := GetQueryInfo(HTTP_QUERY_CONTENT_TYPE);
      if tempStr <> '' then //���� ���� ��������, �� ��������� ���������
        begin
          i := Pos(';', tempStr);
          if i <> 0 then
            Delete(tempStr, i, Length(tempStr));
          //������ ���������� ����� � ������������ � �����
          //�����
          if tempStr = 'text/html' then
            Result := Result + '.html'
          else if tempStr = 'text/plain' then
            Result := Result + '.txt'
          else if tempStr = 'text/css' then
            Result := Result + '.css'
          else if tempStr = 'text/richtext' then
            Result := Result + '.rtx'
          else if tempStr = 'text/rtf' then
            Result := Result + '.rtf'
          else if tempStr = 'text/sgml' then
            Result := Result + '.sgml'
          else if tempStr = 'text/xml' then
            Result := Result + '.xml'
          //�������
          else if tempStr = 'image/bmp' then
            Result := Result + '.bmp'
          else if tempStr = 'image/gif' then
            Result := Result + '.gif'
          else if tempStr = 'image/jpeg' then
            Result := Result + '.jpg'
          else if tempStr = 'image/pjpeg' then
            Result := Result + '.jpg'
          else if tempStr = 'image/png' then
            Result := Result + '.png'
          else if tempStr = 'image/tiff' then
            Result := Result + '.tiff'
          //�����
          else if tempStr = 'audio/3gpp' then
            Result := Result + '.3gp'
          else if tempStr = 'audio/amr' then
            Result := Result + '.amr'
          else if tempStr = 'audio/basic' then
            Result := Result + '.snd'
          else if tempStr = 'audio/midi' then
            Result := Result + '.midi'
          else if tempStr = 'audio/mpeg' then
            Result := Result + '.mp3'
          else if tempStr = 'audio/mp4' then
            Result := Result + '.mp4'
          else if tempStr = 'audio/x-pn-realaudio' then
            Result := Result + '.rm'
          else if tempStr = 'audio/x-pn-realaudio-plugin' then
            Result := Result + '.rpm'
          else if tempStr = 'audio/x-realaudio' then
            Result := Result + '.ra'
          else if tempStr = 'audio/wav' then
            Result := Result + '.wav'
          else if tempStr = 'audio/x-wav' then
            Result := Result + '.wav'
          else if tempStr = 'audio/x-aiff' then
            Result := Result + '.aif'
          //�����
          else if tempStr = 'video/3gpp' then
            Result := Result + '.3gp'
          else if tempStr = 'video/mp4' then
            Result := Result + '.mp4'
          else if tempStr = 'video/mpeg' then
            Result := Result + '.mpeg'
          else if tempStr = 'video/quicktime' then
            Result := Result + '.mov'
          else if tempStr = 'video/x-msvideo' then
            Result := Result + '.avi'
          else if tempStr = 'video/x-sgi-movie' then
            Result := Result + '.movie'
          //�����
          else if tempStr = 'application/java' then
            Result := Result + '.jar'
          else if tempStr = 'application/java-archive' then
            Result := Result + '.jar'
          else if tempStr = 'application/x-gtar' then
            Result := Result + '.gtar'
          else if tempStr = 'application/x-gzip' then
            Result := Result + '.gz'
          else if tempStr = 'application/x-tar' then
            Result := Result + '.tar'
          else if tempStr = 'application/zip' then
            Result := Result + '.zip'
          //������
          else if tempStr = 'application/msword' then
            Result := Result + '.doc'
          else if tempStr = 'application/vnd.ms-excel' then
            Result := Result + '.xls'
          else if tempStr = 'application/vnd.ms-powerpoint' then
            Result := Result + '.ppt'
          {else if tempStr = 'application/octet-stream' then
            Result := Result + '.exe' //.bin .lha}
          else if tempStr = 'application/pdf' then
            Result := Result + '.pdf'
          else if tempStr = 'application/postscript' then
            Result := Result + '.ps'
          else if tempStr = 'application/x-shockwave-flash' then
            Result := Result + '.swf'
        end;
    end;
  //� ������ ������������� ���������� ��� ����� �� Url-������� � ���������� ���
  if Pos('%', Result) <> 0 then
    Result := UrlDecode(Result);
end;

//������� ��������� ������ ������ �� �����
function TDownloadThread.GetInetData(Buffer: Pointer; SizeOfBuffer: Cardinal; var BufferLen: Cardinal; var NumOfRepeat: byte): byte;
{hRequest - ����� �������
 Buffer - ��������� �� ����� ��� ��������� ������
 SizeOfBuffer - ������ ������
 BufferLen - ���������� ���������� ����������� ���� � ���� ��������
 NumOfRepeat - ���������� ���������� �������� ��� ������� �����/�������
 Result:
 0 - ���������� ������ ����� ������
 1 - ������� � ����� �������� ����� ��� ���������� ������������ ����
 2 - ���������� ���������� ��������� ������, ����� ������ ����� �������� � ������
 3 - ���������� ������ �����, ��������� - �����
 4 - ���������� ������ �����, ��������� - �������
}
var
  StatusCode: Cardinal;
begin
  if not InternetReadFile(hRequest, Buffer, SizeOfBuffer, BufferLen) or //���� �� ������� ��������� ������ �� �����
     ((BufferLen = 0) and (FTBytesReaded = 0))                          //��� ������ ���������, �� �����
  then
    begin
      if FTParameters.RepeatOnError then   //���� ����� ����� RepeatOnError
        if (FTParameters.RepeatCount = 0) or (NumOfRepeat < FTParameters.RepeatCount) then //� ���������� �������� ������ ����������� (0 - �������������)
          if ((FTParameters.LoadCount <> 0) and (FTBytesReaded < FTParameters.LoadCount)) or //���� ������ LoadCount � ������� ������ ����������
             ((FTParameters.LoadCount = 0) and (FTBytesReaded < FTDataSize))                     //��� ���� LoadCount = 0 (�������������) � �������� ������ ������� �����
          then
            begin
              Inc(NumOfRepeat); //��������� ��������� ���������� ��������
              //**** ������ ��������� �� ������ ��������
              GetMessage(MSG_DOWNLOAD_ERROR, [NumOfRepeat, FTParameters.RepeatTimeout],
                         [mMessage, mInfo], False);
              //****

              //���� �����, ��������� � RepeatTimeout
              Delay(GetTime, FTParameters.RepeatTimeout);

              if FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP then
                begin
                  Result := 2; //��������� - ������ ���������� �������
                  Exit;
                end;

              //��������� ������� �������
              SendingRequest;
              //�������� ��� ������ �������
              if GetStatusCode(StatusCode) then
                if StatusCode = HTTP_STATUS_OK then
                  if (FTDataSize = 0) or  //���� ������ ����� �� ������� ����������
                     (InternetSetFilePointer(hRequest,
                                             FTParameters.LoadFrom + FTBytesReaded, //��������: ������ ���������� ���������� + ���������� ��������� ������
                                             nil,
                                             FILE_BEGIN,                                //������������ ������ �����
                                             0)
                      = DWORD(-1)) //��� �� ���������� ��������� �� ������ ������� � ��������-�����
                  then
                    begin
                      Result := 2; //��������� - ������ ���������� �������
                      Exit;
                    end;
              Result := 1; //��������� - ������� � ����� ��������
              Exit;
            end;
      Result := 4; //��������� - ���������� ����������� ��������
      Exit;
    end;
  //���� ���������� ����������� ������ ������ ����������, �� ���������� ��� ���������
  if (FTParameters.LoadCount <> 0) and ((FTBytesReaded + BufferLen) > FTParameters.LoadCount) then
    BufferLen := FTParameters.LoadCount - FTBytesReaded;
  Result := IIF(BufferLen = 0,//���� ��� ������ ��������� ��� ������ ������
                3,            //��������� - ���������� ������� �����������
                0);           //�����, ��������� - ���������� ����������
end;

//�������� ������ ��������� �� ����������
procedure TDownloadThread.GetHeaders(out Headers: PChar; out Optional: PChar);
begin
  //���� ������ GET, HEAD ��� ������ ��� ���� ���������
  if (FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'HEAD') or (FTParameters.PostType = ptNone) then
    begin
      //�� ������� �� �����
      Headers := nil;
      Optional := nil;
    end
  else
    //���� ������������ ������ � ����������� � ������ ���������� �� ����
    if (FTParameters.PostType = ptHeaders) and (FTParameters.PostHeaders.Count <> 0) then
      begin
        //�������� ������������ ��������� �� ������ ������
        StrHeaders := FTParameters.PostHeaders.Strings[0];
        //�������� ��������� ���������
        StrOptional := FTParameters.PostHeaders.GetText;
        StrOptional := (Copy(StrOptional,
                             Length(StrHeaders) + 1 + Length(LNBR),//������� ������ ������ ������ � ��������� ����������
                             Length(StrOptional) - Length(StrHeaders) - 2 - Length(LNBR))//������� ������� ���������� ������ � �����
                        );
        if StrHeaders = '' then Headers := nil
          else Headers := PChar(StrHeaders);
        if StrOptional = '' then Optional := nil
          else Optional := PChar(StrOptional);
      end
    else
      begin
        //����� �������� ��������� �� ������
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        Optional := PChar(FTParameters.PostQuery);
      end;
end;

//��������� ������
function TDownloadThread.InetOpen(Flags: Cardinal): boolean;
begin
  hSession := InternetOpen(PChar(FTParameters.UserAgent),  //User Agent
                           FTParameters.InternetAccessType,//��� �������
                           PChar(FTParameters.Proxy),      //����� ������ �������
                           PChar(FTParameters.ProxyBypass),//������, ��� ������� �� ����� ������������� ������
                           Flags);                         //�����
  if Assigned(hSession) then
    begin
      //**** ���� ������� ������� ������ ������ ���������
      GetMessage(MSG_INTERNET_OPEN_OK, [],
                 [mMessage, mOk], False);
      //****
      Result := True;
    end
  else
    begin
      Result := False;
      LastError := GetLastError;
      //**** ���� �� ������� ������� ������ ������ ���������
      GetMessage(MSG_INTERNET_OPEN_ERROR, [],
                 [mMessage, mError], True);
      //****
    end;
end;

//������� ����������
function TDownloadThread.InetConnect(Flags: Cardinal): boolean;
var
  Service: Cardinal;
begin
  case FTUrlStructure.NumScheme of
    INTERNET_SCHEME_HTTP:   Service := INTERNET_SERVICE_HTTP;
    INTERNET_SCHEME_HTTPS:  Service := INTERNET_SERVICE_HTTP;
    INTERNET_SCHEME_FTP:    Service := INTERNET_SERVICE_FTP;
    INTERNET_SCHEME_GOPHER: Service := INTERNET_SERVICE_GOPHER;
  else
    Service := INTERNET_SERVICE_Url;
  end;
  hConnect := InternetConnect(hSession,                        //����� �������� ������
                              PChar(FTUrlStructure.Host),      //����
                              FTUrlStructure.Port,             //����
                              PChar(FTParameters.AuthUserName),//����� ��� ������� � �����
                              PChar(FTParameters.AuthPassword),//������ ��� ������� � �����
                              Service,                         //������������ ������
                              Flags,                           //�����
                              0);
  if Assigned(hConnect) then
    begin
      //**** ���� ������� ������� ���������� ������ ���������
      GetMessage(MSG_INTERNET_CONNECT_OK, [FTUrlStructure.Host],
                 [mMessage, mOk], False);
      //****
      if FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP then
        GetMessage(MSG_SERVER_ANSVER, [GetLastResponseInfo(LastError)],
                   [mMessage, mInfo], False);
      Result := True;
    end
  else
    begin
      Result := False;
      LastError := GetLastError;
      //**** ���� �� ������� ������� ���������� ������ ���������
      GetMessage(MSG_INTERNET_CONNECT_ERROR, [FTUrlStructure.Host],
                 [mMessage, mError], True);
      if (LastError <> ERROR_INTERNET_EXTENDED_ERROR) and (FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP) then
        GetMessage(MSG_SERVER_ANSVER, [GetLastResponseInfo(LastError)],
                   [mMessage, mInfo], False);
      //****
    end;
end;

//���������� ��� FTP ����� HTTP-������ � GOPHER
function TDownloadThread.InetOpenUrl(Flags: Cardinal): boolean;

  function CreateUrl: string;
  begin
    Result := FTUrlStructure.Scheme + '://';
    if (FTUrlStructure.UserName = '') and (FTParameters.AuthUserName <> '') then
      begin
        Result := Result + FTParameters.AuthUserName;
        if FTParameters.AuthPassword <> '' then
          Result := Result + ':' + FTParameters.AuthPassword;
        Result := Result + '@';
      end;
    Result := Result + FTUrlStructure.Host;
    Result := Result + ':' + IntToStr(FTUrlStructure.Port);
    Result := Result + FTUrlStructure.UrlPath;
    Result := Result + FTUrlStructure.ExtraInfo;
  end;

  function ParseDataSize(const Str: string): Cardinal;
  var
    tmpStr: string;
    i: integer;
  begin
    Result := 0;
    i := Pos('213 ', Str);
    if i <> 0 then
      begin
        tmpStr := Copy(Str, i + 4, Length(Str) - i + 4);
        i := Pos(LNBR, tmpStr);
        if i <> 0 then
          Delete(tmpStr, i, Length(tmpStr) - i + 1);
        Result := StrToInt(tmpStr);
      end;
  end;

var
  Headers: PChar;//������������ ���������
  Optional: PChar;//��������� ���������
  Ansver: string;
begin
  //�������� ������ ���������
  GetHeaders(Headers, Optional);
  if (Headers <> nil) and (Optional <> nil) then
    Headers := PChar(Headers + LNBR + Optional);
  hConnect := InternetOpenUrl(hSession,         //������ ������, �������� InternetOpen
                              PChar(CreateUrl), //���� � �����
                              Headers,          //��������� �������
                              Length(Headers),  //������ ���������� �������
                              Flags,            //�����
                              0);               //��������
  if Assigned(hConnect) then
    begin
      hRequest := hConnect;
      //**** ���� ������� ������� ������ ������ ���������
      GetMessage(MSG_INTERNET_CONNECT_OK, [FTParameters.Url],
                 [mMessage, mOk], False);
      if FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP then
        begin
          Ansver := GetLastResponseInfo(LastError);
          if Ansver <> '' then
            begin
              GetMessage(MSG_SERVER_ANSVER, [Ansver],
                         [mMessage, mInfo], False);
              FTDataSize := ParseDataSize(Ansver);
            end;
        end;
      //****
      Result := True;
    end
  else
    begin
      Result := False;
      LastError := GetLastError;
      //**** ���� �� ������� ������� ������ ������ ���������
      GetMessage(MSG_INTERNET_CONNECT_ERROR, [FTParameters.Url],
                 [mMessage, mError], True);
      if (LastError <> ERROR_INTERNET_EXTENDED_ERROR) and (FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP) then
        GetMessage(MSG_SERVER_ANSVER, [GetLastResponseInfo(LastError)],
                   [mMessage, mInfo], False);
      //****
    end;
end;

//������� ������
function TDownloadThread.OpenRequest(Flags: Cardinal): boolean;
begin
  hRequest := HttpOpenRequest(hConnect,                         //����� ��������� ����������
                              PChar(FTParameters.RequestMethod),//��� �������
                              PChar(FTUrlStructure.UrlPath + FTUrlStructure.ExtraInfo),//���� ��� + ������ �������
                              HTTP_VERSION,//HTTP/1.0           //������
                              PChar(FTParameters.Referer),      //Referer
                              @FTParameters.AcceptTypes,        //��������� ���� ������
                              Flags,                            //�����
                              0);
  if Assigned(hRequest) then
    begin
      //**** ���� ������� ������� ������ ������ ���������
      GetMessage(MSG_OPEN_REQUEST_OK, [FTParameters.RequestMethod],
                 [mMessage, mOk], False);
      //****
      Result := True;
    end
  else
    begin
      Result := False;
      LastError := GetLastError;
      //**** ���� �� ������� ������� ������ ������ ���������
      GetMessage(MSG_OPEN_REQUEST_ERROR, [FTParameters.RequestMethod],
                 [mMessage, mError], True);
      //****
    end;
end;

//������� ftp-����
function TDownloadThread.FtpFindFile(Flags:Cardinal; var FtpFile: TWin32FindData):boolean;
{Flags - �����
 FtpFile - ���������, ���������� �������� � �����
}
begin
  hRequest := FtpFindFirstFile(hConnect,
                               PChar(FTUrlStructure.UrlPath),
                               FtpFile,
                               Flags,
                               0);
  if Assigned(hRequest) then
    begin
      //**** ���� ������� ������� ���� ������ ���������
      GetMessage(MSG_FTP_FIND_FILE_OK, [FTUrlStructure.UrlPath],
                 [mMessage, mOk], False);
      GetMessage(MSG_SERVER_ANSVER, [GetLastResponseInfo(LastError)],
                 [mMessage, mInfo], False);
      //****
      Result := True;
    end
  else
    begin
      Result := False;
      LastError := GetLastError;
      //**** ���� �� ������� ������� ���� ������ ���������
      GetMessage(MSG_FTP_FIND_FILE_ERROR, [FTUrlStructure.UrlPath],
                 [mMessage, mError], True);
      //****
    end;
end;

function TDownloadThread.FtpSendCommand(const FtpCommandStr: string; var Ansver: string): boolean;
var
  ExpectResponse: boolean;//������ ������
  IsWrite: boolean;//������� ������ ������
  ErrCode: Cardinal;
begin
  Result := False;

  //���� ���� ����������� ������� ������ �����
  if ((Pos('APPE', UpperCase(FtpCommandStr)) = 1) or
      (Pos('STOR', UpperCase(FtpCommandStr)) = 1) or
      (Pos('STOU', UpperCase(FtpCommandStr)) = 1)) then
    begin
      //���������� �������� � �������� ������
      ExpectResponse := True;
      IsWrite := True;
    end
  else
    begin
      //���������� �������� ��� ������� ������
      ExpectResponse := False;
      IsWrite := False;
    end;
  if not FtpCommand(hConnect,                          //������ InternetConnect
                    ExpectResponse,                    //���������� �����
                    FTP_TRANSFER_TYPE_BINARY,          //����, ������������ ��� ������������� ������
                    PChar(FtpCommandStr),              //������� FTP (������ ����� ���������� ���: http://www.nsftools.com/tips/RawFTP.htm)
                    0,                                 //�������� (��� ������������ ������)
                    hRequest)                          //������, � �������� InternetReadFile ����� ������ ������������ ������
  then
    begin //���� �������� �� �����������
      LastError := GetLastError;
      ExpectResponse := True;
      Ansver := GetLastResponseInfo(ErrCode);
      //������ ����� ������� �� ������ "425" � ��� ������� �������
      if not ((Pos('425', Ansver) = 1) and
        //�������������� �������� � �������� ������
        FtpCommand(hConnect,
                   ExpectResponse,
                   FTP_TRANSFER_TYPE_BINARY,//FTP_TRANSFER_TYPE_ASCII
                   PChar(FtpCommandStr),
                   0,
                   hRequest))
        then begin
          Ansver := GetLastResponseInfo(ErrCode);
          //*** ���� �� �������, ������ ��������� ***
          GetMessage(MSG_FTP_COMMAND_ERROR, [FtpCommandStr],
                     [mMessage, mError], True);
          //*******
          Exit;//� �������
        end;
    end;
  //*** ���� �������, ������ ��������� ***
  Ansver := GetLastResponseInfo(ErrCode);
  GetMessage(MSG_FTP_COMMAND_OK, [FtpCommandStr, Ansver],
             [mMessage, mOk], False);
  //�, ��� �������������, �������� ������
  if ExpectResponse then
    begin
      if IsWrite then
        Result := InetWriteFile
      else
        Result := InetReadFile
    end
  else
    Result := True;
  //*******
end;

function TDownloadThread.FtpSendingCommand: boolean;
var
  FtpCommandStr: string;//������ ������� FTP
  Headers, Optional: PChar;//���������� ���������
  Ansver: string;

  i: integer;
begin
  i := 0;

  //�������� ������ ��������
  FtpCommandStr := FTParameters.RequestMethod;
  if FTParameters.PostType = ptHeaders then
    begin
      GetHeaders(Headers, Optional);
      if (FtpCommandStr = '') and (Headers <> nil) then
        begin
          FtpCommandStr := String(Headers);
          Inc(i);
        end;
    end
  else if FTParameters.PostType = ptQuery then
    if FTParameters.PostQuery <> '' then
      FtpCommandStr := IIF(FtpCommandStr <> '',
                           FtpCommandStr + ' ' + FTParameters.PostQuery,
                           FTParameters.PostQuery);

  Result := FtpSendCommand(FtpCommandStr, Ansver);

  if Result and ((FTParameters.PostType = ptHeaders) and (Optional <> nil)) then
    begin
      while i < FTParameters.PostHeaders.Count do
        begin
          if not FtpSendCommand(FTParameters.PostHeaders.Strings[i], Ansver) then
            begin
              Result := False;
              Break;
            end;
          inc(i);
        end;
    end;
end;

function TDownloadThread.FtpSetCurrentDir(FtpFile: TWin32FindData): boolean;
var
  tempStr: string;
begin
  if ((FtpFile.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = FILE_ATTRIBUTE_DIRECTORY)then
    begin
      tempStr := FTUrlStructure.UrlPath;
      if (FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'POST') then
        FTParameters.RequestMethod := 'LIST ' + FTUrlStructure.UrlPath;
    end
  else
    begin
      tempStr := Copy(FTUrlStructure.UrlPath, 1, LastDelimiter('/', FTUrlStructure.UrlPath));
    end;
  Result := FtpSetCurrentDirectory(hConnect, PChar(tempStr));
end;

//��������� ftp-����
function TDownloadThread.FtpOpen(Flags, Access: Cardinal): boolean;
{Flags - �����
 Access - ��� �������: GENERIC_READ ��� GENERIC_WRITE (�� �� ��� ������!)
}
begin
  hRequest := FtpOpenFile(hConnect,                         //����� ��������� ����������
                          PChar(FTUrlStructure.UrlPath),    //���� � �����
                          Access,                           //��� �������
                          Flags,                            //�����
                          0);
  if Assigned(hRequest) then
    begin
      //**** ���� ������� ������� ���� ������ ���������
      GetMessage(MSG_OPEN_FTP_OK, [FTUrlStructure.UrlPath],
                 [mMessage, mOk], False);

      GetMessage(MSG_SERVER_ANSVER, [GetLastResponseInfo(LastError)],
                 [mMessage, mInfo], False);
      //****
      Result := True;
    end
  else
    begin
      Result := False;
      //**** ���� �� ������� ������� ���� ������ ���������
      LastError := GetLastError;
      GetMessage(MSG_OPEN_FTP_ERROR, [FTUrlStructure.UrlPath],
                 [mMessage, mError], True);
      //****
    end;
end;

//������� �������� ������� � �������� ������
function TDownloadThread.SendingRequest: boolean;
var
  StatusCode: Cardinal;
  Send: boolean; //��������� �������� �������

  dwFlags: Cardinal; //����� ��� InternetOpenUrl
begin
  Result := False;
  if FTUseOpenUrl then
    begin
      //��������� �����: �� ������������ ��� ��� �������� �����, ������������ ���������� (�����, ���� �� ������� �������� �����/������), ������������ ������������ ����������
      dwFlags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT or INTERNET_FLAG_RELOAD;
      //�������� ����: ������������ ��������� ����� FTP
      if (FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP) and FTParameters.FtpPassive then
        dwFlags := dwFlags or INTERNET_FLAG_PASSIVE;

      Send := InetOpenUrl(dwFlags);
    end
  else
    if FTParameters.Downloading then
      Send := SendRequest
    else
      Send := SendRequestEx;

  if Send then
    begin
      //**** ���� ������� ��������� ������ ������ ���������
      GetMessage(MSG_SEND_REQUEST_OK, [],
                 [mMessage, mOk], False);
      //****
    end
  else //���� ��������� ������ �� ������� - �������
    Exit;

  dwFlags := GetHandleType;
  if ((dwFlags = INTERNET_HANDLE_TYPE_HTTP_REQUEST) or (dwFlags = INTERNET_HANDLE_TYPE_CONNECT_HTTP)) then
    begin
      //�������� ��� ������ �������
      if not GetStatusCode(StatusCode) then
        begin
          LastError := GetLastError;
          //**** ���� �� ������� �������� ��� ������ �������, ������ ���������
          GetMessage(MSG_QUERY_INFO_ERROR, [],
                     [mMessage, mError], True);
          //****
            Exit; //� �������
        end;
      //���� ��� ������ - ��������� ����������� ������
      if StatusCode = HTTP_STATUS_PROXY_AUTH_REQ then
        SetProxyAuth(StatusCode);
      //���� ����� ������� �� ����� - ��
      while StatusCode >= HTTP_STATUS_AMBIGUOUS{300} do
        begin
          if not GetErrorDlg(StatusCode, True) then
            begin
              if StatusCode <> 0 then
                GetMessage(MSG_QUERY_INFO_HTTP, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                          [mResult, mInfo], False);
              //�������� ����� �������
              InetReadFile;
              Exit;//� �������
            end
        end;
    end;
  Result := True
end;

//���������� ������
function TDownloadThread.SendRequest: boolean;
var
  Headers: PChar;//������������ ���������
  Optional: PChar;//��������� ���������
  StatusCode: Cardinal;
begin
  //�������� ������ ���������
  GetHeaders(Headers, Optional);
  //���������� �� �� ������� �������
  Result := HttpSendRequest(hRequest, Headers, Length(Headers), Optional, Length(Optional));

  if not Result then
    Result := GetErrorDlg(StatusCode, False);
end;

//������� ������������ ������� (��� ������� ����� �� ������ ������� PUT)
function TDownloadThread.SendRequestEx: boolean;
var
  InternetBuf : INTERNET_BUFFERS;//��������-����� ��� �������� � HTTPsendRequestEX
  StatusCode: Cardinal;
begin
  Result := False;

  SetLoadParameters;

  //��������� ��������� InternetBuf
  ZeroMemory(@InternetBuf, SizeOf(InternetBuf));
  InternetBuf.dwStructSize := SizeOf(InternetBuf);
  InternetBuf.dwBufferTotal := FTNeedDataSize;

  //�������� ������
  if not HttpSendRequestEX(hRequest, @InternetBuf, nil, HSR_INITIATE, 0) then //HSR_INITIATE - ��������, ��� �������� ����� ��������� ������ ����� ������� HttpEndRequest
    begin
      LastError := GetLastError;
      //**** ���� �� ������� ��������� ������, ������ ���������
      GetMessage(MSG_SEND_REQUEST_ERROR, [],
                 [mMessage, mError], True);
      //****
      Exit; //� �������
    end
  else
    if not InetWriteFile then
      Exit;
  //��������� �������� �������
  Result := HttpEndRequest(hRequest, nil, 0, 0);

  //���� ��������� ������ �������, ���������
  if GetLastError = ERROR_INTERNET_FORCE_RETRY then
    Result := SendRequestEx;

  if not Result then
    Result := GetErrorDlg(StatusCode, False);
end;

//��������� �������������� � ������
function TDownloadThread.SetProxyAuth(var StatusCode: Cardinal): boolean;
begin
  Result := False;
  //������ �����/������ ��� ������
  if FTParameters.ProxyUserName <> '' then
    Result := InternetSetOption(hConnect,
                      INTERNET_OPTION_PROXY_USERNAME,
                      Pointer(FTParameters.ProxyUserName),
                      Length(FTParameters.ProxyUserName) + 1);
  if FTParameters.ProxyPassword <> '' then
    Result := InternetSetOption(hConnect,
                      INTERNET_OPTION_PROXY_PASSWORD,
                      Pointer(FTParameters.ProxyPassword),
                      Length(FTParameters.ProxyPassword) + 1);
  if Result then
    //� �������������� ������
    if FTParameters.Downloading or FTUseOpenUrl then
      SendRequest
    else
      SendRequestEx;
  Result := GetStatusCode(StatusCode);
end;

//��������� ������ InternetErrorDlg
function TDownloadThread.GetErrorDlg(var StatusCode: Cardinal; Auth: boolean): boolean;
var
  Data: pointer; //���������, ����� ��� ����������� � InternetErrorDlg
begin
  Data := nil;
  Result := False;
  //������� ������� InternetErrorDlg
  case InternetErrorDlg(FTOwnerHandle,                       //����� ����, � ������� ����� ����������� ������
                        hRequest,                            //����� �������
                        LastError,                           //��� ������
                        FLAGS_ERROR_UI_FILTER_FOR_ERRORS or  //�����: ����������� ������ ��� ������ ������� ������, �� ��������� � ���� ������
                        FLAGS_ERROR_UI_FLAGS_GENERATE_DATA or//����������� ������ ������ �� ������ (����� ��������� � Data)
                        FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS, //��������� ��������� ������ ������� � ������
                        Data)
  of
    ERROR_SUCCESS:   begin{0} //����� ���� ���� ������, ��� ������� ��������������, ��� ����� ���� ��, ��� ������� ��������� ����������� (��� �������� ���������, ��������� ��� ������ ����������)
                       if Auth then
                         //**** ��������� ��������� � ������� ������ �������
                         GetMessage(MSG_QUERY_INFO_HTTP_ERROR, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                                    [mMessage, mError], False)
                         //****
                       else
                         begin
                           //�������������� ������
                           if FTParameters.Downloading or FTUseOpenUrl then
                             Result := SendRequest
                           else
                             Result := SendRequestEx;
                           if Result then
                             Result := GetStatusCode(StatusCode);
                         end;
                     end;
    ERROR_CANCELLED: begin{1223} //����� ���� ���� ������, ��� ������� ��������� �����������
                       //**** ��������� ��������� � ������� ��������� ������
                       LastError := GetLastError;
                       GetMessage(MSG_SEND_REQUEST_ERROR, [],
                                  [mMessage, mError], True);
                       //****
                     end;
    ERROR_INTERNET_FORCE_RETRY:{12032} //����� ��������� ������������ �������
                     begin
                       //�������������� ������
                       if FTParameters.Downloading or FTUseOpenUrl then
                         Result := SendRequest
                       else
                         Result := SendRequestEx;
                       if Result then
                         Result := GetStatusCode(StatusCode);
                     end;
    ERROR_INVALID_HANDLE:{6} //���� ������ �������� ����� ���� (Handle = 0, ����� �� ��������� ���������� ������)
                     begin
                       LastError := GetLastError;
                       if Auth then //���������� ��������� � ������� ������ �������
                         begin
                           GetStatusCode(StatusCode);
                           GetMessage(MSG_QUERY_INFO_HTTP_ERROR, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                                      [mMessage, mError], False);
                         end
                       else //��� ������� ��������� ������
                         GetMessage(MSG_SEND_REQUEST_ERROR, [],
                                    [mMessage, mError], True);
                       //****
                     end;
  end;
end;

function TDownloadThread.InetReadFile: boolean;
var
  ReadBuffer: PChar; //����� ���������� ������
  BufferLen: Cardinal;  //������ ���������� �� ��� ������
  StartPos: Cardinal;//������� ��� ������ � ����
  NumOfRepeat: byte; //���������� �������� �������
  tempStr: string;

  CurrTime: int64;
  CurrBytesReaded: Cardinal;
begin
  Result := False;
  CurrBytesReaded := 0;
  //�������� ������ ��� ����� ������
  ReadBuffer := StrAlloc(FTParameters.BufferSize);
  try
    SetLoadParameters;
    //���������� ��������� InternetSetFilePointer, �.�. �� ������� ��������-����� ������� ��� ����������� �������,
    //�� ������ ���������, ���� �� ������� ���������� Content-Length (MSDN �� ��������� ������, �� ��������� �������� InternetReadFile)
    if FTDataSize <> 0 then
      StartPos := InternetSetFilePointer(hRequest,                 //����� �������
                                         FTParameters.LoadFrom,//��������, �������� ������
                                         nil,
                                         FILE_BEGIN,               //������������ ������ �����
                                         0);
    //���� ��������� ��������� ��������� ��� InternetSetFilePointer - �� ����������
    if (StartPos = DWORD(-1)) or (FTDataSize = 0) then
      begin
        StartPos := 0;//�� ���������� ������� ��� ������ �� ������ �����
        if FTParameters.LoadCount <> 0 then
          //� ��������� LoadCount �� ��������� ������ �������� (���� �� ����������, ��� ���� �������� 200 ����, ������� � 100-��, � ��� ��������� 200 ���� � ������; ������ ����� �������� 300 ����, � ������� � ����� ������� ����������� ������)
          Inc(FTParameters.LoadCount, FTParameters.LoadFrom);
      end;

    //���� ������ ������ ��������� � ������������ �������� ���������� ������, ����������� ���������
    if (FTDataSize <> 0) and (StartPos + FTParameters.LoadCount > FTDataSize) then
      if StartPos < FTDataSize then //���� ��������� ������� ���������� ������ ��� ��������� ������
        //�� ��������� ���������� ��������� ������, �� ����������� ����������
        FTParameters.LoadCount := FTDataSize - StartPos
      else //�����, ������ 0 (��� �������� - ������ ���)
        FTParameters.LoadCount := 0;

    NumOfRepeat := 0;//�������� ���������� �������� ��� �������
    FTCurrentTime := GetTime;

    //���� ��� �������� ������ - ������ ��� �����
    if (FTParameters.TypeOfData = odString) or (FTParameters.TypeOfData = odStream) then
      begin
        while True do begin //���� �� ����� �� ������ �������� Break
          BufferLen := 0;
          //�������� ������ ������ �� ����� � ������������ ��� ������ ���������
          case GetInetData(ReadBuffer, FTParameters.BufferSize, BufferLen, NumOfRepeat) of
            0: ;                    //���������� ���������� ����� ������ �� �����
            1: Continue;            //�������� ����� �������� �����, ��������� ������ ���� �������
            2: begin                //�������� ��� �������� �������� � �������� ����� �������� �����
                 FTBytesReaded := 0;
                 FTRecivedString := '';
                 if Assigned(FTRecivedStream) then
                   FTRecivedStream.SetSize(0);
                 Continue;
               end;
            3: begin                //������� �� ����� � ����������� - �����
                 Result := True;
                 Break;
               end;
            4: begin                //������� �� ����� � ����������� - �������
                 Result := False;
                 Break;
               end;
          end;
          tempStr := ReadBuffer; //���������� ���������� ������ � ������
          SetLength(tempStr, BufferLen); //������������� ��������� ������ ������
          if FTParameters.TypeOfData = odStream then
            begin
              FTRecivedStream.Write(PChar(tempStr)^, Length(tempStr));
            end
          else
            begin
              FTRecivedString := FTRecivedString + tempStr; //��������� ������ � ��� ���������� ������
            end;
          FTBytesReaded := (FTBytesReaded + BufferLen); //������� ���������� ���������� ������
          //**** ������� ���������� ���������� ������
          GetMessage(IntToStr(FTBytesReaded), [],
                     [mProgress, mBytesReaded], False);

          //�������� ������� �����
          CurrTime := GetTime;
          //���� ������ ������ ������ ���������� ����������
          if BufferLen >= MIN_SIZE_TO_CALCULATE then
            begin
              //�� ������� ��������
              GetMessage(IntToStr(GetSpeed(BufferLen, FTCurrentTime, CurrTime)), [],
                         [mProgress, mSpeed], False);
              FTCurrentTime := CurrTime;
            end
          else //���� ������
            begin
              //�� ���������� ���������� ������
              CurrBytesReaded := (CurrBytesReaded + BufferLen);
              //���� ��� �� ����� ������ ���������� ����������
              if CurrBytesReaded >= MIN_SIZE_TO_CALCULATE then
                begin
                  //����� ������� ��������
                  GetMessage(IntToStr(GetSpeed(CurrBytesReaded, FTCurrentTime, CurrTime)), [],
                             [mProgress, mSpeed], False);
                  CurrBytesReaded := 0;
                  FTCurrentTime := CurrTime;
                end;
            end;
          //****
        end;
      end
    //���� ��� �������� ������ - ����
    else if FTParameters.TypeOfData = odFile then
      begin
        //� ����������� �� ���������� ���� ������
        case FTParameters.WriteMethod of
          wmSaveBytePos: begin //� ����������� ������� ��� � ��������-�����:
                          //������� ���� *�������* �������, � ��������� �������������
                          if not SetFileSize(FTParameters.FileName, FTDataSize, True) then
                            Exit;
                        end;
          wmRewrite:    begin //����������:
                          //������� ���� *����������* �������, ��� �������� �������������
                          if FTParameters.LoadCount <> 0 then
                            begin
                              if not SetFileSize(FTParameters.FileName, FTParameters.LoadCount, False) then
                                Exit;
                            end
                          else
                            if not SetFileSize(FTParameters.FileName, FTDataSize, False) then
                              Exit;
                          //������������� ������� ������ �� ������ �����
                          StartPos := 0;
                        end;
          wmAppend:     begin //����������:
                          //������������� ������� ������ ������ DWORD(-1) - ����� ������ ����� ���������� � ������������� �����
                          StartPos := DWORD(-1);
                        end;
        end;

        while True do begin //���� �� ����� �� ������ �������� Break
          BufferLen := 0;
          //�������� ������ ������ �� ����� � ������������ ��� ������ ���������
          case GetInetData(ReadBuffer, FTParameters.BufferSize, BufferLen, NumOfRepeat) of
            0: ;                    //���������� ���������� ����� ������ �� �����
            1: Continue;            //�������� ����� �������� �����, ��������� ������ ���� �������
            2: begin
                 if FTParameters.WriteMethod = wmAppend then //���� �� ��������� ������ � �����
                   StartPos := StartPos - FTBytesReaded //�� ��������� � ������ ����������
                 else //� ��������� �������
                   StartPos := 0; //��������� � ������ ����� (��� wmSaveBytePos - ��� ���������, �.�. � ������ ���������� ������� ����, ������ �����(?), �� ���� ����������)
                 FTBytesReaded := 0;//�������� ���������� ���������� ������
                 Continue;          //�������� ����� �������� �����
               end;
            3: begin                //������� �� ����� � ����������� - �����
                 Result := True;
                 Break;
               end;
            4: begin                //������� �� ����� � ����������� - �������
                 Result := False;
                 Break;
               end;
          end;
          //���������� ���������� ������ � ����
          if not WriteFile(FTParameters.FileName, ReadBuffer, BufferLen, StartPos) then
            begin
              Result := False;
              Exit;
            end;
          //������� ���������� ���������� ������
          FTBytesReaded := (FTBytesReaded + BufferLen);
          //**** ������� ���������� ���������� ������
          GetMessage(IntToStr(FTBytesReaded), [],
                     [mProgress, mBytesReaded], False);

          CurrTime := GetTime;
          if BufferLen >= MIN_SIZE_TO_CALCULATE then
            begin
              GetMessage(IntToStr(GetSpeed(BufferLen, FTCurrentTime, CurrTime)), [],
                         [mProgress, mSpeed], False);
              FTCurrentTime := CurrTime;
            end
          else
            begin
              CurrBytesReaded := (CurrBytesReaded + BufferLen);
              if CurrBytesReaded >= MIN_SIZE_TO_CALCULATE then
                begin
                  GetMessage(IntToStr(GetSpeed(CurrBytesReaded, FTCurrentTime, CurrTime)), [],
                             [mProgress, mSpeed], False);
                  CurrBytesReaded := 0;
                  FTCurrentTime := CurrTime;
                end;
            end;
          //****
        end;
      end;
  finally
    //���� �������� �������������� ������
    if CurrBytesReaded > 0 then
      //��������� ��������
      GetMessage(IntToStr(GetSpeed(CurrBytesReaded, FTCurrentTime, GetTime)), [],
                 [mProgress, mSpeed], False);
    //����������� ������
    StrDispose(ReadBuffer);
  end;
end;

//������ ������ �� ������
function TDownloadThread.InetWriteFile: boolean;
var
  Buffer: PChar;     //����� ������
  BufSize: Cardinal; //������ ����������� ������ � ������
  tempStr: string;   //��������� ������ ��� �������� ������
  BytesWriten: Cardinal;//������ ���������� �� ������ ������, ����

  StartPos: Cardinal;
begin
  Result := False;
  if FTDataSize = 0 then
    Exit;

  StartPos := FTParameters.LoadFrom;

  //�������� ������ ��� ����� ������
  Buffer := StrAlloc(FTParameters.BufferSize);
  try
    //�������� ��������� ��������
    BytesWriten :=0;
    FTBytesReaded := 0;
    BufSize := 0;
    //��������� ���� ������ �����
    while FTBytesReaded < FTNeedDataSize do
      begin
        with FTParameters do begin
          case TypeOfData of
            odFile:   begin //�������� ����
                        //��������� ������ �� ����� � �����, ���������� ������ ��������� ������
                        BufSize := ReadFile(FileName, Buffer, BufferSize, StartPos);
                      end;
            odString: begin //�������� ������
                        //�������� ����� ������������ ������ ������� �������
                        tempStr := Copy(UploadingString, StartPos, BufferSize);
                        //������������� ������ ������������� ������
                        BufSize := Length(tempStr);
                        //�������� ������ � �����
                        Buffer := PChar(tempStr);
                      end;
            odStream: begin //�������� �����
                        //��������� ����� �� ������ �������
                        FTUploadingStream.Seek(StartPos, soFromBeginning);
                        //��������� ������ �� ������ � ����� � ���������� ������ ������������
                        BufSize := FTUploadingStream.Read(Buffer^, BufferSize);
                      end;
          end;
        end;

        if BufSize > FTNeedDataSize then
          BufSize := FTNeedDataSize
        else if BufSize = 0 then
          Break;

        if not InternetWriteFile(hRequest, Buffer, BufSize, BytesWriten) then //���� ��������� ������ ��� ������ ����� �� ������
          begin
            LastError := GetLastError;
            //������ ���������
            GetMessage(MSG_INTERNET_WRITE_FILE_ERROR, [],
                   [mMessage, mError], True);
            Exit;//� ��������� ����
          end;
        //����������� ������� ������ �����
        Inc(FTBytesReaded, BytesWriten);
        StartPos := FTBytesReaded;
        GetMessage(IntToStr(FTBytesReaded), [],
                   [mProgress, mBytesReaded], False);
      end;
    Result := True;
  finally
    Buffer := nil;     //������� ������
    StrDispose(Buffer);//����������� ������
  end;
end;

//��������� ������
procedure TDownloadThread.CloseHandles;
begin
  InternetCloseHandle(hRequest);
  InternetCloseHandle(hConnect);
  InternetCloseHandle(hSession);
end;

function TDownloadThread.HttpDownload: boolean;
var
  dwFlags: Cardinal; //����� ��� HttpOpenRequest

  StatusCode: Cardinal; //�������� ��� ������ �������
  tempStr: string; //��� ������ ���������� � ������

  StartPos: Cardinal;//������� ��� ������ � ����
begin
  //--������� �������� ��������--
  Result := False;

  //**** ��������� ��������� ���������� ��������� �������
  tempStr := '*URL*: ' + FTParameters.Url + '; *RequestMethod*: ' + FTParameters.RequestMethod;
  if ((FTParameters.RequestMethod <> 'GET') and (FTParameters.RequestMethod <> 'HEAD') and
    (FTParameters.PostType = ptQuery)) and (FTParameters.PostQuery <> '') then
    tempStr := tempStr + '; *' + FTParameters.RequestMethod + '-Query*: ' + FTParameters.PostQuery;
  GetMessage(MSG_PARAMETERS_INFO, [tempStr],
             [mMessage, mInfo], False);
  //****

  //��������� ������
  if InetOpen(0) then
    try
      //������� ����������
      if InetConnect(INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT) then //�����: ������������ ���������� (�����, ���� �� ������� �������� �����/������), ������������ ������������ ����������
        begin
          //��������� �����
          dwFlags := IIF(FTUrlStructure.NumScheme = INTERNET_SCHEME_HTTPS, //���� ����������� - https
                         INTERNET_FLAG_SECURE or //�� ������������ ����. �����: ������������ ���������� ���������� (SSL/PCT)
                         SECURITY_INTERNET_MASK, //������������ ������������ ����������� � ���������
                         0);//���� ���������� �� https, �� �������������� ������ �� �����
          dwFlags := dwFlags or INTERNET_FLAG_RELOAD;//�������� ����: �� ������������ ��� ��� �������� �����

          //������� ������
          if OpenRequest(dwFlags) then
            begin
              //�������� ������
              if SendingRequest then
                //**** ������ ��������� �� �������� ��������� ���������� �� �������
                GetMessage(MSG_QUERY_INFO_OK, [],
                           [mMessage, mOk], False)
                //****
              else
                Exit;

              GetStatusCode(StatusCode);

              //���� ����� ����� AutoFileName � ��� �������� ������ - ����
              if FTParameters.AutoFileName and (FTParameters.TypeOfData = odFile) then
                //��������� ��� �����, ��� ���� �� ���������� �������� + ��� �����, ������������ �� ���
                FTParameters.FileName := ExtractFilePath(FTParameters.FileName) + GetFileName;

              //�������� �������� ������ ������������� ������
              FTDataSize := GetDataSize;
              if FTDataSize <> 0 then //���� ������� ���������� ������
                begin
                  //**** ������� ��������� � ������� ������
                  GetMessage(MSG_QUERY_CONTENT_LENGTH_OK, [FormatFileSize(FTDataSize)],
                             [mMessage, mDataSize], False);
                  //****
                end
              else //�����
                begin
                  //**** ������� ��������� �� ������ ����������� ������� ������
                  GetMessage(MSG_QUERY_CONTENT_LENGTH_ERROR, [],
                             [mMessage, mDataSize], False);
                  //****
                end;
              //**** �������� ������ ������������� ������
              GetMessage(IntToStr(FTDataSize), [],
                         [mProgress, mDataSize], False);
              //****

              //������� ��������� ������ ����������� ������ �����
              FTNeedDataSize := FTDataSize;

              //��� HEAD-������� � ���������������� ��������
              if not ((FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'POST')) then
                begin
                  FTCurrentTime := GetTime;
                  FTRecivedString := '';
                  //-- �������� ������ ���� �� ���������� --
                  tempStr := GetQueryInfo(HTTP_QUERY_RAW_HEADERS_CRLF or HTTP_QUERY_FLAG_REQUEST_HEADERS);
                  if tempStr <> '' then FTRecivedString := FTRecivedString + tempStr + LNBR + LNBR;
                  tempStr := GetQueryInfo(HTTP_QUERY_RAW_HEADERS_CRLF);
                  if tempStr <> '' then FTRecivedString := FTRecivedString + tempStr + LNBR;
                  //-----
                  //������ ����������� ������ ������ ��� ������ ���������� ����
                  FTBytesReaded := Length(FTRecivedString);

                  //���� ����� ����� � �����
                  if FTParameters.TypeOfData = odStream then
                    FTRecivedStream.Write(PChar(FTRecivedString)^, FTBytesReaded)

                  //���� ����� ����� � ����
                  else if (FTBytesReaded <> 0) and (FTParameters.TypeOfData = odFile) then
                    begin
                      //������ ���������� �����, ���� ��������, ��� �� �������� ��������� HEAD-�������
                      if FTParameters.AutoFileName then
                        FTParameters.FileName := FTParameters.FileName + '_' + FTParameters.RequestMethod + '.txt';
                      //���� ����� ������ �� "����������"
                      if FTParameters.WriteMethod <> wmAppend then
                        begin
                          StartPos := 0; //���������� ������� ������ �� ������ �����
                          //������ ������ �����
                          SetFileSize(FTParameters.FileName, FTBytesReaded, False);
                        end
                      else//��� ������ "����������"
                        //���������� ������� ������ ������ DWORD(-1) - ����� ������ ����� ���������� � ������������� �����
                        StartPos := DWORD(-1);
                      //�������� RecivedString � ����
                      WriteFile(FTParameters.FileName, PChar(FTRecivedString), FTBytesReaded, StartPos);
                    end;

                  //**** ������� ���������� ���������� ������
                  GetMessage(IntToStr(FTBytesReaded), [],
                             [mProgress, mBytesReaded], False);
                  GetMessage(MSG_PING, [GetTimeDiff(FTCurrentTime, GetTime)],
                             [mMessage, mInfo], False);
                  //****
                  Result := FTBytesReaded <> 0; //������� �������� ���������, ���� ���� ��������� ������
                end
              else //��� ������ ��������
                begin
                  //��������� ������������ � ���������� ��������� ����� �� �����
                  Result := InetReadFile;
                  if Result then //� ������ ������
                    begin
                      //**** ������� ���������
                      case FTParameters.TypeOfData of
                        odString: tempStr := MSG_DOWNLOAD_STRING_OK;
                        odStream: tempStr := MSG_DOWNLOAD_STREAM_OK;
                        odFile:   tempStr := Format(MSG_DOWNLOAD_FILE_OK, [FTParameters.FileName]);
                      end;
                      GetMessage(tempStr, [],
                                 [mMessage, mOk], False);
                      //****
                    end;
                end;

              if StatusCode <> 0 then
                GetMessage(MSG_QUERY_INFO_HTTP, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                           [mResult, mInfo], False)
            end;
        end;
    finally //�������� ������
      CloseHandles;
    end;
end;

function TDownloadThread.HttpUpload: boolean;
var
  StatusCode: Cardinal;
  dwFlags: Cardinal; //����� ��� HttpOpenRequest
begin
  //--������� �������� ��������--
  Result := False;

  //���������� ������ ������������ ������
  case FTParameters.TypeOfData of
    odFile:   FTDataSize := GetFileSize(FTParameters.FileName);
    odString: FTDataSize := Length(FTParameters.UploadingString);
    odStream: FTDataSize := FTUploadingStream.Size;
  else
    FTDataSize := 0;
  end;
  if FTDataSize = DWORD(-1) then
    begin
      LastError := GetLastError;
      //***������� ��������� �� ������ ***
      GetMessage(MSG_OPEN_FILE_ERROR, [FTParameters.FileName],
                 [mMessage, mInfo], True);
      Exit;//� �������
      //*********
    end;

  //��������� ������
  if InetOpen(0) then
    try
      //������� ����������
      if InetConnect(INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT) then //�����: ������������ ���������� (�����, ���� �� ������� �������� �����/������), ������������ ������������ ����������
        begin
          //��������� �����
          dwFlags := IIF(FTUrlStructure.NumScheme = INTERNET_SCHEME_HTTPS, //���� ����������� - https
                         INTERNET_FLAG_SECURE or //�� ������������ ����. �����: ������������ ���������� ���������� (SSL/PCT)
                         SECURITY_INTERNET_MASK, //������������ ������������ ����������� � ���������
                         0);//���� ���������� �� https, �� �������������� ������ �� �����
          dwFlags := dwFlags or INTERNET_FLAG_RELOAD{ or INTERNET_FLAG_NO_CACHE_WRITE};//�������� �����: �� ������������ ��� ��� �������� � ������� �����

          //������� ����� �������������� ������� 'PUT'
          FTParameters.RequestMethod := 'PUT';

          //������� ������
          if OpenRequest(dwFlags) then
            begin
              GetMessage(MSG_FILE_SIZE, [FormatFileSize(FTDataSize)],
                         [mMessage, mDataSize], False);
              GetMessage(IntToStr(FTDataSize), [],
                         [mProgress, mDataSize], False);

              FTCurrentTime := GetTime;
              if SendingRequest then
                begin
                  //����������� ��������
                  GetMessage(IntToStr(GetSpeed(FTBytesReaded, FTCurrentTime, GetTime)), [],
                             [mProgress, mSpeed], False);

                  //**** ������ ��������� �� �������� ��������� ���������� �� �������
                  GetMessage(MSG_QUERY_INFO_OK, [],
                             [mMessage, mOk], False);
                  //****
                end
              else
                Exit;

              if GetStatusCode(StatusCode) then
                 Result := (StatusCode < HTTP_STATUS_AMBIGUOUS{300});

              if StatusCode <> 0 then
                GetMessage(MSG_QUERY_INFO_HTTP, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                           [mResult, mInfo], False);

              FTparameters.Url := GetQueryOptions(INTERNET_OPTION_URL);
            end;
        end;
    finally //�������� ������
      CloseHandles;
    end;
end;

function TDownloadThread.FtpDownload: boolean;
var
  tempStr: string; //��� ������ ���������� � ������
  dwFlags: Cardinal;//�����

  StartPos: Cardinal;//������� ��� ������ � ����

  FtpFile: TWin32FindData;//�������� � ����� �� �������
begin
  //--������� �������� ��������--
  Result := False;

  //**** ��������� ��������� ���������� ��������� �������
  tempStr := '*URL*: ' + FTParameters.Url;
  if not ((FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'POST') or
    (FTParameters.RequestMethod = 'HEAD')) then
    begin
      tempStr := tempStr + '; *COMMAND*: ' + FTParameters.RequestMethod;
      if (FTParameters.PostType = ptQuery) and (FTParameters.PostQuery = '') then
        tempStr := tempStr + ' ' + FTParameters.PostQuery;
    end;
  GetMessage(MSG_PARAMETERS_INFO, [tempStr],
             [mMessage, mInfo], False);
  //****

  //��������� ������
  if InetOpen(0) then
    try
      //�����: ������������ ���������� (�����, ���� �� ������� �������� �����/������), ������������ ������������ ����������
      dwFlags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT;
      //�������� ����: ������������ ��������� ����� FTP
      if FTParameters.FtpPassive then
        dwFlags := dwFlags or INTERNET_FLAG_PASSIVE;

      //������� ����������
      if InetConnect(dwFlags) then
        begin
          FTCurrentTime := GetTime;
          //������� ����
          if not FtpFindFile(0, FtpFile) then
            Exit //���� ���� �� ������ - �������
          else
            begin
              //���������� ������ �����
              FTDataSize := FtpFile.nFileSizeLow;

              //**** �������� ������ ������������� ������
              GetMessage(IntToStr(FTDataSize), [],
                         [mProgress, mDataSize], False);
              //****

              //���� ����� ����� AutoFileName � ��� �������� ������ - ����
              if FTParameters.AutoFileName and (FTParameters.TypeOfData = odFile) then
                //��������� ��� �����, ��� ���� �� ���������� �������� + ��� �����, ������������ �� ���
                FTParameters.FileName := ExtractFilePath(FTParameters.FileName) + GetFileName;

              FtpSetCurrentDir(FtpFile);

              //������� ��������� ������ ����������� ������ �����
              FTNeedDataSize := FTDataSize;

              if not ((FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'POST')) then
                begin
                  FTCurrentTime := GetTime;

                  //��� HEAD-�������
                  if FTParameters.RequestMethod = 'HEAD' then
                    begin
                      //-- �������� ������ ���� --
                      FTRecivedString := Format(MSG_FTP_FILE_INFO, [FtpFile.cFileName,
                        FileAttrToStr(FtpFile.dwFileAttributes), FormatFileSize(FtpFile.nFileSizeLow),
                        FileTimeToStr(FtpFile.ftCreationTime), FileTimeToStr(FtpFile.ftLastWriteTime),
                        FileTimeToStr(FtpFile.ftLastAccessTime)]);

                      FTBytesReaded := Length(FTRecivedString);

                      //���� ����� ����� � �����
                      if FTParameters.TypeOfData = odStream then
                        FTRecivedStream.Write(PChar(FTRecivedString)^, FTBytesReaded)

                      //���� ����� ����� � ����
                      else if (FTBytesReaded <> 0) and (FTParameters.TypeOfData = odFile) then
                        begin
                          //������ ���������� �����, ���� ��������, ��� �� �������� ��������� HEAD-�������
                          if FTParameters.AutoFileName then
                            FTParameters.FileName := FTParameters.FileName + '_' + FTParameters.RequestMethod + '.txt';
                          //���� ����� ������ �� "����������"
                          if FTParameters.WriteMethod <> wmAppend then
                            begin
                              StartPos := 0; //���������� ������� ������ �� ������ �����
                              //������ ������ �����
                              SetFileSize(FTParameters.FileName, FTBytesReaded, False);
                            end
                          else//��� ������ "����������"
                            //���������� ������� ������ ������ DWORD(-1) - ����� ������ ����� ���������� � ������������� �����
                            StartPos := DWORD(-1);
                          //�������� RecivedString � ����
                          WriteFile(FTParameters.FileName, PChar(FTRecivedString), FTBytesReaded, StartPos);
                        end;

                      Result := FTBytesReaded <> 0; //������� �������� ���������, ���� ���� ��������� ������
                    end
                  else
                    Result := FtpSendingCommand;

                  //**** ������� ���������� ���������� ������
                  GetMessage(IntToStr(FTBytesReaded), [],
                             [mProgress, mBytesReaded], False);
                  GetMessage(MSG_PING, [GetTimeDiff(FTCurrentTime, GetTime)],
                             [mMessage, mInfo], False);
                  //****
                end
              else //��� ������ ��������
                begin
                  //��������� �����
                  dwFlags := FTP_TRANSFER_TYPE_BINARY or INTERNET_FLAG_RELOAD;//�������� ����: �� ������������ ��� ��� �������� �����

                  //if FTParameters.LoadFrom <> 0 then
                    //if not FtpSendCommand('REST '+IntToStr(FTParameters.LoadFrom), tempStr) then
                      //begin
                        //if FTParameters.LoadCount <> 0 then
                          //Inc(FTParameters.LoadCount, FTParameters.LoadFrom);
                        //FTParameters.LoadFrom := 0;
                      //end;

                  if FtpOpen(dwFlags, GENERIC_READ) then
                    begin
                      //��������� ������������ � ���������� ��������� ����� �� �����
                      Result := InetReadFile;
                      if Result then //� ������ ������
                        begin
                          //**** ������� ���������
                          case FTParameters.TypeOfData of
                            odString: tempStr := MSG_DOWNLOAD_STRING_OK;
                            odStream: tempStr := MSG_DOWNLOAD_STREAM_OK;
                            odFile:   tempStr := Format(MSG_DOWNLOAD_FILE_OK, [FTParameters.FileName]);
                          end;
                          GetMessage(tempStr, [],
                                     [mMessage, mOk], False);
                          //****
                        end;
                    end;
                end;
            end;
        end;
    finally //�������� ������
      CloseHandles;
    end;
end;

function TDownloadThread.FtpUpload: boolean;
var
  dwFlags: Cardinal; //����� ��� FtpOpen
  tempStr: string;
begin
  //--������� �������� ��������--
  Result := False;

  //���������� ������ ������������ ������
  case FTParameters.TypeOfData of
    odFile:   FTDataSize := GetFileSize(FTParameters.FileName);
    odString: FTDataSize := Length(FTParameters.UploadingString);
    odStream: FTDataSize := FTUploadingStream.Size;
  else
    FTDataSize := 0;
  end;
  if FTDataSize = DWORD(-1) then
    begin
      LastError := GetLastError;
      //***������� ��������� �� ������ ***
      GetMessage(MSG_OPEN_FILE_ERROR, [FTParameters.FileName],
                 [mMessage, mInfo], True);
      Exit;//� �������
      //*********
    end;

  //��������� ������
  if InetOpen(0) then
    try
      //�����: ������������ ���������� (�����, ���� �� ������� �������� �����/������), ������������ ������������ ����������
      dwFlags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT;
      //�������� ����: ������������ ��������� ����� FTP
      if FTParameters.FtpPassive then
        dwFlags := dwFlags or INTERNET_FLAG_PASSIVE;
      //������� ����������
      if InetConnect(dwFlags) then //�����: ������������ ���������� (�����, ���� �� ������� �������� �����/������), ������������ ������������ ����������
        begin
          FTCurrentTime := GetTime;
          SetLoadParameters;
          if FTParameters.WriteMethod = wmSaveBytePos then
            begin
               if FtpSendCommand('REST ' + IntToStr(FTParameters.LoadFrom), tempStr) then
                 Result := FtpSendCommand('STOR ' + FTUrlStructure.UrlPath, tempStr)
            end
          else if FTParameters.WriteMethod = wmAppend then
            begin
              Result := FtpSendCommand('APPE ' + FTUrlStructure.UrlPath, tempStr);
            end
          else
            begin
              dwFlags := FTP_TRANSFER_TYPE_BINARY or INTERNET_FLAG_RELOAD;//�������� ����: �� ������������ ��� ��� �������� �����
              if FtpOpen(dwFlags, GENERIC_WRITE) then
                Result := InetWriteFile;
            end;

          if Result then
            //������� ��������
            GetMessage(IntToStr(GetSpeed(FTBytesReaded, FTCurrentTime, GetTime)), [],
                       [mProgress, mSpeed], False);

          FTparameters.Url := GetQueryOptions(INTERNET_OPTION_URL);
        end;
    finally //�������� ������
      CloseHandles;
    end;
end;

//����� ������� ���������� ��� HTTP, FTP � GOPHER
function TDownloadThread.InetDownload: boolean;
var
  StatusCode: Cardinal; //�������� ��� ������ �������
  tempStr: string; //��� ������ ���������� � ������
begin
  //--������� �������� ��������--
  Result := False;
  FTDataSize := 0;

  //**** ��������� ��������� ���������� ��������� �������
  tempStr := '*URL*: ' + FTParameters.Url;
  GetMessage(MSG_PARAMETERS_INFO, [tempStr],
             [mMessage, mInfo], False);
  //****

  //��������� ������
  if InetOpen(0) then
    try
      //������� ���������� � �������� ������
      if SendingRequest then
        //**** ������ ��������� �� �������� ��������� ���������� �� �������
        GetMessage(MSG_QUERY_INFO_OK, [],
                   [mMessage, mOk], False)
        //****
      else
        Exit;

      GetStatusCode(StatusCode);

      //���� ����� ����� AutoFileName � ��� �������� ������ - ����
      if FTParameters.AutoFileName and (FTParameters.TypeOfData = odFile) then
        //��������� ��� �����, ��� ���� �� ���������� �������� + ��� �����, ������������ �� ���
        FTParameters.FileName := ExtractFilePath(FTParameters.FileName) + GetFileName;

      //�������� �������� ������ ������������� ������
      if FTDataSize = 0 then
        FTDataSize := GetDataSize;

      if FTDataSize <> 0 then //���� ������� ���������� ������
        begin
          //**** ������� ��������� � ������� ������
          GetMessage(MSG_QUERY_CONTENT_LENGTH_OK, [FormatFileSize(FTDataSize)],
                     [mMessage, mDataSize], False);
          //****
        end
      else //�����
        begin
          //**** ������� ��������� �� ������ ����������� ������� ������
          GetMessage(MSG_QUERY_CONTENT_LENGTH_ERROR, [],
                     [mMessage, mDataSize], False);
          //****
        end;
      //**** �������� ������ ������������� ������
      GetMessage(IntToStr(FTDataSize), [],
                 [mProgress, mDataSize], False);
      //****

      //������� ��������� ������ ����������� ������ �����
      FTNeedDataSize := FTDataSize;

      //��������� ������������ � ���������� ��������� ����� �� �����
      Result := InetReadFile;
      if Result then //� ������ ������
        begin
          //**** ������� ���������
          case FTParameters.TypeOfData of
            odString: tempStr := MSG_DOWNLOAD_STRING_OK;
            odStream: tempStr := MSG_DOWNLOAD_STREAM_OK;
            odFile:   tempStr := Format(MSG_DOWNLOAD_FILE_OK, [FTParameters.FileName]);
          end;
          GetMessage(tempStr, [],
                     [mMessage, mOk], False);
          //****
        end;

      if StatusCode <> 0 then
        GetMessage(MSG_QUERY_INFO_HTTP, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                   [mResult, mInfo], False)
    finally //�������� ������
      CloseHandles;
    end;
end;

end.
