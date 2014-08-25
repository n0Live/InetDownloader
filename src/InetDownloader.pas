{****************************************************}
{* Компонент InetDownloader                         *}
{* Автор: Egor Krasnopolin                          *}
{* 09/07/2009                                       *}
{*                                                  *}
{* Компонент предназначен для получения  данных  из *}
{* интернета в виде файла, строки или потока. Также *}
{* при помощи компонента  можно "заливать" файлы на *}
{* сервер.                                          *}
{****************************************************}
{*                                                  *}
{* *** СВОЙСТВА: ***                                *}
{* AcceptTypes - разрешенные для загрузки типы дан- *}
{*   ных.                                           *}
{* UserAgent - строка содержашая значение UserAgent.*}
{* AuthPassword -  пароль,  для  аутентификации  на *}
{*   сервере.                                       *}
{* AuthUserName -  логин,  для   аутентификации  на *}
{*   сервере.                                       *}
{* AutoFileName - переключатель,  при  установке  в *}
{*   TRUE - имя файла присваивается  автоматически, *}
{*   на основе сведений, полученных из интернета.   *}
{* BufferSize - размер  буфера приема/передачи дан- *}
{*   ных.  Автоматически  приводится  к  ближайшему *}
{*   числу, выражающемуся в степени двойки.         *}
{* LoadCount -  размер получаемого содержимого, байт*}
{* LoadFrom - смещение, относительно начала, для    *}
{*   получения данных. Если размер  содержимого оп- *}
{*   ределить не удается, то смещение  устанавлива- *}
{*   ется равным 0, а значение LoadCount увеличива- *}
{*   ется на величину первоначального смещения.     *}
{* FileName -  имя  получаемого   файла,  в  случае *}
{*   AutoFileName = TRUE - из этого свойства берет- *}
{*   ся только путь к файлу.                        *}
{* InternetAccessType - тип доступа к интернету:    *}
{*   atDirect - прямое соединение;                  *}
{*   atPreconfig - использует настройки из реестра; *}
{*   atProxy - соединение через прокси-сервер;      *}
{*   atPreconfigWithNoAutoProxy - использует  наст- *}
{*     ройки из  реестра, но  предотвращает  запуск *}
{*     Microsoft JScript или Internet Setup (INS).  *}
{* LocalIP - вовращает локальный IP-адрес компьютера*}
{* Name - имя компонента.                           *}
{* PostHeaders - заголовки POST/Custom-запроса.     *}
{* PostQuery - строка POST/Custom-запроса.          *}
{* PostType - тип используемого POST/Custom-запроса:*}
{*   ptNone - дополнительные заголовки не передаются*}
{*   ptHeaders - заголовки(для multipart/form-data);*}
{*   ptQuery - строка (для x-www-form-urlencoded).  *}
{* Proxy - адрес  прокси-сервера  в  формате:       *}
{*   url:port или http=url:port ftp=url:port...     *}
{* ProxyBypass - список адресов, для которых не тре-*}
{*   буется использовать прокси-сервер. Адреса раз- *}
{*   деляются символом (;), разрешается использова- *}
{*   ние масок и макроса <local>.                   *}
{* ProxyPassword - пароль к прокси-серверу.         *}
{* ProxyUserName - логин к прокси-серверу.          *}
{* Referer - ссылка  на страницу, с которой произо- *}
{*   шел вызов ссылки на требуемые данные.          *}
{* RepeatCount - количество повторов при ошибке со- *}
{*   единения.                                      *}
{* RepeatOnError -  переключатель,  если  TRUE - то *}
{*   при ошибке соединения будет выполнено перепод- *}
{*   ключение.                                      *}
{* RepeatTimeout - время  ожидания в миллисекундах, *}
{*   после которого будет выполнено переподключение.*}
{* ReportLevel - уровень выводимой  информации, чем *}
{*   больше параметров выбрано, тем больше дополни- *}
{*   тельной инфы будет передано.                   *}
{*  Параметры ReportLevel:                          *}
{*  mResult - результат выполнения;                 *}
{*  mProgress - размер данных и скорость соединения;*}
{*  mMessage - прочие сообщения;                    *}
{*  mOk -  успешный   результат   (используется   с *}
{*    mResult и mMessage);                          *}
{*  mError -  ошибка   выполнения  (используется  с *}
{*    mResult и mMessage);                          *}
{*  mInfo - дополнительные  данные  (используется с *}
{*    mResult и mMessage);                          *}
{*  mDataSize - общий размер получаемых/передаваемых*}
{*    данных,  байт  (используется  с  mProgress  и *}
{*    mMessage);                                    *}
{*  mBytesRead - текущий  размер полученных/отправ- *}
{*    ленных данных, байт (используется с mProgress)*}
{*  mSpeed -  текущая  скорость  соединения, байт/с *}
{*    (используется с mProgress).                   *}
{* RequestMethod - метод посылки запроса. Поддержи- *}
{*   ваются методы: Get, Post и Head, а  также есть *}
{*   возможность установить пользовательский метод. *}
{*   Для этого выбирается значение rmCustom и вызы- *}
{*   вается метод SetCustomRequestMethod(Value).    *}
{*   Примечание: после устнановки значения rmCustom,*}
{*   вызов метода SetCustomRequestMethod ОБЯЗАТЕЛЕН!*}
{* ShowErrorDlg - переключатель, если TRUE - то при *}
{*   некоторых ошибках доступа будет  показано диа- *}
{*   логовое окно  для  решения  возникших  проблем *}
{*   (ввод логина/пароля, получение сертификата).   *}
{* SpeedLimit - ограничение  скорости,  байт/с. При *}
{*   0 - скорость неограничена.                     *}
{* ThreadsList - список объектных ссылок  на  запу- *}
{*   щенные потоки.                                 *}
{* Url - строка, содержащая адрес требуемых данных. *}
{* WaitOnWorkEnd - переключатель, если TRUE - то да-*}
{*   льнейший код в процедуре  не будет  выполнятся *}
{*   пока не завершится поток получения данных.     *}
{* WininetVersion - возвращает  версию используемой *}
{*   библиотеки wininet.                            *}
{* WriteMethod - метод записи в файл:               *}
{*   wmRewrite - файл будет перезаписан, резервиру- *}
{*     ется сразу весь необходимый размер, что пре- *}
{*     пятствует фрагментации.                      *}
{*   wmAppend - данные будут добавленны в конец су- *}
{*     ществующего файла, размер не резирвируется.  *}
{*   wmSaveBytePos - данные будут  записаны в то же *}
{*     место файла, откуда  они  были  взяты.  Если *}
{*     файл не существует или  его размер отличает- *}
{*     ся от требуемого, то файл будет перезаписан. *}
{*     Размер резервируется.                        *}
{*                                                  *}
{* *** МЕТОДЫ: ***                                  *}
{* Abort[Index] - прекратить выполнение запущенного *}
{*   потока. Параметр Index определяет какой именно *}
{*   поток  требуется  завершить. Index  берется из *}
{*   списка ThreadsList, начальное значение - 0.    *}
{*   При  вызове без  параметров завершается поток, *}
{*   запущенный последним.                          *}
{* DownloadFile - получить данные в виде файла.     *}
{* DownloadString - получить данные в виде строки.  *}
{* DownloadStream - получить данные в виде потока.  *}
{* GetMaxConnsPerServer(MaxConnsPer1_0Server,       *}
{*  MaxConnsPerServer) - получение текущего значения*}
{*   параметров максимального количества подключений*}
{*   к одному серверу. Параметры возвращают -1 при  *}
{*   неудаче.                                       *}
{* SetMaxConnsPerServer(MaxConnsPer1_0Server,       *}
{*  MaxConnsPerServer) - установить  значение  пара-*}
{*   метров максимального  количества подключений к *}
{*   одному серверу.                                *}
{* SetCustomRequestMethod(Value) - установка пользо-*}
{*   вательского типа запроса.  Параметр Value пред-*}
{*   ставляет собой название пользовательского типа *}
{*   запроса. Возвращает True - при  успешной  уста-*}
{*   новке типа и False -  при  неудаче (напр. если *}
{*   значение свойства  RequestMethod отличается от *}
{*   rmCustom).                                     *}
{* UploadFile - залить файл на http- (методом 'PUT')*}
{*   либо ftp-сервер.                               *}
{* UploadString(Str) - залить строку Str  на  http- *}
{*   (методом 'PUT') либо ftp-сервер.               *}
{* UploadStream(Stream) - залить  поток  Stream  на *}
{*   http- (методом 'PUT') либо ftp-сервер.         *}
{*                                                  *}
{* *** СОБЫТИЯ: ***                                 *}
{* OnDownloadFileDone - вызывается  при завершении  *}
{*   получения файла. Передает следующие параметры: *}
{*   Sender - объектная ссылка на тред;             *}
{*   FileName - имя полученного файла;              *}
{*   DataSize - размер затребованных данных, байт;  *}
{*   BytesReaded - размер прочитанных данных, байт; *}
{*     Может быть как меньше DataSize(при неудачном *}
{*     завершении), так и больше (при невозможности *}
{*     установить смещение);                        *}
{*   Result - результат получения данных (успех или *}
{*     неудача).                                    *}
{* OnDownloadStringDone - вызывается при завершении *}
{*   получения строки. Передает следующие параметры:*}
{*   Sender - объектная ссылка на тред;             *}
{*   RecivedString - строка с полученными данными;  *}
{*   DataSize - размер затребованных данных, байт;  *}
{*   BytesReaded - размер прочитанных данных, байт; *}
{*   Result - результат получения данных (успех или *}
{*     неудача).                                    *}
{* OnDownloadStreamDone - вызывается при завершении *}
{*   получения потока. Передает следующие параметры:*}
{*   Sender - объектная ссылка на тред;             *}
{*   RecivedStream - полученный поток данных;       *}
{*   DataSize - размер затребованных данных, байт;  *}
{*   BytesReaded - размер прочитанных данных, байт; *}
{*   Result - результат получения данных (успех или *}
{*     неудача).                                    *}
{* OnUploadDone - вызывается при завершении отправки*}
{*   данных на сервер. Передает следующие параметры:*}
{*   Sender - объектная ссылка на тред;             *}
{*   Adress - строка с Url отправленных данных;     *}
{*   DataSize - размер затребованных данных, байт;  *}
{*   BytesWriten - размер записанных данных, байт;  *}
{*   Result - результат получения данных (успех или *}
{*     неудача).                                    *}
{* OnGiveMessage - вызывается при получении сообще- *}
{*   ния от потока. Передает следующие параметры:   *}
{*   Sender - объектная ссылка на поток;            *}
{*   MsgTypes - тип сообщения (см. ReportLevel);    *}
{*   Msg - содержание сообщения.                    *}
{*                                                  *}
{****************************************************}

unit InetDownloader;

interface

uses
  Windows, Messages, SysUtils, Classes,
  WinInet2, Additional;

type
  //Тип запроса
  TRequestMethod = (rmGet, rmPost, rmHead, rmCustom);
  //Способ посылки запросов с телом сообщения
  TPostType = (ptNone, ptQuery, ptHeaders);
  //Тип посылаемого сообщения
  TMsgType = (mOk,          //Успешное завершение
              mError,       //Ошибка
              mInfo,        //Дополнительные сведения
              mResult,      //Результат выполнения потока
              mMessage,     //Прочие сообщения
              mProgress,    //Прогресс скачивания
              mDataSize,    //Общий размер получаемых данных, байт (0 - если не удалось определить)
              mBytesReaded, //Размер прочитанных данных, байт. Увеличивается с каждой итерацией.
              mSpeed);      //Текущая скорость, байт/с
  TMsgTypes = set of TMsgType;
  //Тип выходных данных
  TTypeOfData = (odFile,   //Файл
                    odString, //Строка
                    odStream);//Поток
  //Тип доступа
  TInternetAccessType = (atPreconfig,                //Использует настройки из реестра
                         atDirect,                   //Прямой доступ
                         atProxy,                    //Через прокси
                         atPreconfigWithNoAutoProxy);//Использует настройки из реестра и предотвращает запуск Microsoft JScript или Internet Setup (INS)
  //Метод записи в файл
  TWriteMethod = (wmRewrite,     //Перезапись (+ резервируется весь размер файла)
                  wmAppend,      //Добавление (полученные данные записываются в конец файла)
                  wmSaveBytePos);//С сохранением позиции (резервируется весь размер файла, данные записываются в ту же область файла, из которой они были полученны)
                                 //если файл существует и его размер соответствует получаемому, то данные просто записываются внутрь этого файла

  TOnGiveMessage = procedure (Sender: TObject; MsgTypes: TMsgTypes; Msg: string) of object;  //Процедура обработки посылаемого сообщения
  TOnDownloadFileDone = procedure (Sender: TObject; FileName: string; DataSize, BytesReaded: Cardinal; Result: boolean) of object; //Процедура обработки завершения скачивания файла
  TOnDownloadStreamDone = procedure (Sender: TObject; RecivedStream: TMemoryStream; DataSize, BytesReaded: Cardinal; Result: boolean) of object; //Процедура обработки завершения скачивания потока
  TOnDownloadStringDone = procedure (Sender: TObject; RecivedString: string; DataSize, BytesReaded: Cardinal; Result: boolean) of object; //Процедура обработки завершения получения строки
  TOnUploadDone = procedure (Sender: TObject; Adress: string; DataSize, BytesWriten: Cardinal; Result: boolean) of object; //Процедура обработки завершения заливки данных на сервер

  //Параметры соединения
  TParameters = record
    AcceptTypes: string;      //  Разрешенные типы получаемых данных (*/* - все типы)
    UserAgent: string;        //  User Agent (по-умолчанию - имя программы)
    Url: string;              //  Url файла, который нужно получить
    AuthUserName: string;     //  Имя пользователя для Autentification: Basic
    AuthPassword: string;     //  Пароль для Autentification: Basic
    FileName: string;         //  Имя файла, для сохранения
    RequestMethod: string;    //  Тип запроса: GET, POST, PUT, HEAD и тд.
    PostType: TPostType;      //  Способ отправки запроса с телом сообщения: ptNone - без тела; ptQuery - формат как у GET запроса; ptHeaders - пользователь сам заполняет все заголовки
    PostQuery: string;        //  Строка POST и PUT запроса
    PostHeaders: TStringList; //  POST-запрос в виде заголовков, нужен, например, для загрузки файла на сервер через форму. Спецификация заголовков описана в RFC 1867
    Referer: string;          //  Ссылка на Referer
    Proxy: string;            //  Адрес прокси-сервера
    ProxyBypass: string;      //  Адреса, для которых не нужно использовать прокси-сервер
    ProxyUserName: string;    //  Имя пользователя для прокси
    ProxyPassword: string;    //  Пароль для прокси
    InternetAccessType: Cardinal;//Тип доступа: Direct, Preconfig, Proxy, PreconfigWithNoAutoProxy
    ReportLevel: TMsgTypes;   //  Уровень выводимой информации
    LoadFrom: Cardinal;       //  Начальная позиция для скачивания, байт
    LoadCount: Cardinal;      //  Количество получаемых данных, байт
    TypeOfData: TTypeOfData;  //  Тип принимаемых/передаваемых данных (файл, строка)
    SpeedLimit:Cardinal;      //  Ограничение скорости, байт/с
    RepeatOnError: boolean;   //  Повторять закачку при ошибке связи/сервера
    RepeatCount: byte;        //  Количество повторов закачки (0 - бесконечно)
    RepeatTimeout: Cardinal;  //  Таймаут, после которого будет повтор закачки (мс)
    AutoFileName: boolean;    //  Получать имя файла автоматически
    WriteMethod: TWriteMethod;//  Метод записи в файл
    BufferSize: Cardinal;     //  Размер буфера

    UploadingString: string;  //  Загружаемая строка
    UploadingStream: TStream; //  Ссылка на загружаемый поток
    Downloading: boolean;     //  При True - будет выполнятся DownloadData, при False - UploadData

    FtpThroughHttpProxy: boolean;//При True - получение/отправка файлов через FTP будет осуществлятся с помощью InternetOpenUrl, для совместимости с Http-прокси
    FtpPassive: boolean;      //  При True - будет использоваться пассивный режим соединения с FTP
  end;

 //====Сортируем свойства по подгруппам====
  //Прокси
  TProxy = record
    Proxy: string;
    UserName: string;
    Password: string;
    Bypass: string;
  end;
  //Заголовки запроса
  TRequestHeaders = record
    AcceptTypes: string;
    Referer: string;
    UserAgent: string;
  end;
  //Параметры соединения
  TConnectionParams = record
    Url: string;
    UserName: string;
    Password: string;
  end;
  //Параметры отправки POST-запроса
  TPostParams = record
    PostType: TPostType;
    Query: string;
    Headers: TStringList;
  end;
  //Параметры соединения с FTP
  TFtpParams = record
    FtpThroghHttpProxy: boolean;
    Passive: boolean;
  end;
  //========================================

  //Структура Url: <схема>://<логин>:<пароль>@<хост>:<порт>/<Url-путь>
  TUrlStructure = record
    Scheme: string;        //схема
    NumScheme: TInternetScheme;//номер схемы
    UserName: string;      //логин
    Password: string;      //пароль
    Host: string;          //хост
    Port: INTERNET_PORT;   //порт
    UrlPath: string;       //Url-путь
    ExtraInfo: string;     //доп. инфо. (например, строка GET-запроса)
  end;

//===== TDownloadThread =========================
  TDownloadThread = class(TThread)
  private
    FTParameters: TParameters;  //  Параметры соединения
    FTMessageType: TMsgTypes;   //  Тип посылаемого сообщения
    FTMessage: string;          //  Текст посылаемого сообщения
    FTRecivedString: string;    //  Выходная строка
    FTRecivedStream: TMemoryStream; //Выходной поток данных
    FTOnGiveMessage: TOnGiveMessage;//Событие обработки сообщения
    FTDataSize: Cardinal;       //  Размер получаемых данных, байт
    FTNeedDataSize: Cardinal;   //  Размер требуемых данных, байт
    FTBytesReaded: Cardinal;    //  Количество прочитанных байт
    FTResult: boolean;          //  Результат (успех/неудача)
    FTOwnerHandle: HWND;        //  Хендл компонента-владельца (нужен для вывода InternetErrorDlg)
    FTUrlStructure: TUrlStructure;//Структура Url
    FTCurrentTime: int64;       //  Время запуска процедур передачи/получения данных
    FTUploadingStream: TMemoryStream;//Поток данных для заливки на сервер
    FTUseOpenUrl: boolean;      //  При True - прием данных будет осуществлятся при помощи InternetOpenUrl
    hSession: HINTERNET;        // \
    hConnect: HINTERNET;        //  Указатели на сессию
    hRequest: HINTERNET;        // /
    LastError: Cardinal;        //  Код последней ошибки
    Freq: int64;                //  Частота, необходима для определения времени
    StrHeaders: string;         // \Заголовки, должны быть объявленны глобально
    StrOptional: string;        // /иначе возникают ошибки
    procedure GetMessage(FormatMsg: string; Args: array of TVarRec; MsgTypes: TMsgTypes; Error: boolean);
    procedure UpdateMessage;    //  Обработка сообщения (нужно для синхронизации)
    function GetLastResponseInfo(var Error: Cardinal): string;//Получение дополнительных данных при ошибке
    function GetTime: int64;    //  Определение времени для вычисления скорости соединения
    function GetTimeDiff(StartTime, FinishTime: int64): Cardinal;//Вычисление разности между двумя значениями времени, мс
    procedure Delay(FromTime: int64; Delay: Cardinal);//Задержка на заданное время (мс)
    function SetFileSize(const FileName: string; NewSize: Cardinal; CheckFile: boolean): boolean;//Функция резервирования размера файла
    function WriteFile(const FileName: string; Buf: PChar; BufLength: Cardinal; var WritePosition: Cardinal): boolean;//Функция записи файла
    function ReadFile(const FileName: string; out Buf: PChar; BufLength: Cardinal; ReadPosition: Cardinal): Cardinal; //Функция чтения файла
    function GetSpeed(Bytes: Cardinal; PrevTime, CurrTime: int64): Cardinal;//Функция определения скорости соединения, байт/с
    function ParseUrl(const Url: String; out UrlStructure: TUrlStructure): boolean;//Функция парсинга Url
    procedure SetLoadParameters;//  Проверка и установка параметров загузки данных
    function GetStatusCode(var StatusCode: Cardinal): boolean;//Получение кода ответа сервера
    function GetQueryInfo(dwInfoLevel: Cardinal): string;//Функция получения информации от запроса
    function GetQueryOptions(dwInfoLevel: Cardinal): string;//Получение значеный параметров интернет-соединения
    function GetDataSize: Cardinal;  // Функция получения размера данных
    function GetHandleType: Cardinal;// Функция получения типа возвращаемого хендла
    function GetFileName: string;    // Функция получения имени файла
    function GetInetData(Buffer: Pointer; SizeOfBuffer: Cardinal; var BufferLen: Cardinal; var NumOfRepeat: byte): byte;//Функция получения порции данных из инета
    procedure GetHeaders(out Headers: PChar; out Optional: PChar);//Получение предаваемых заголовков из PostHeaders
    function InetConnect(Flags: Cardinal): boolean;//Установка соединения с интернетом
    function InetOpen(Flags: Cardinal): boolean;//Открытие сессии
    function InetOpenUrl(Flags: Cardinal): boolean;//Открытие сессии и отправка запроса с использованием InternetOpenUrl
    function SetProxyAuth(var StatusCode: Cardinal): boolean;//Установка авторизации на прокси-сервере
    function GetErrorDlg(var StatusCode: Cardinal; Auth: boolean): boolean;//Получение окна диалога для обработки ошибок(получение сертификата, ввод логина)
    function InetReadFile: boolean;  // Чтение данных из интернета
    function InetWriteFile: boolean; // Запись данных на сервер
    function OpenRequest(Flags: Cardinal): boolean;//Создание запроса
    function FtpFindFile(Flags:Cardinal; var FtpFile: TWin32FindData):boolean;//Поиск файла на ftp-сервере
    function FtpSendCommand(const FtpCommandStr: string; var Ansver: string): boolean;//Отправка одиночной ftp-команды
    function FtpSendingCommand: boolean;//Отправка всех подготовленных команд ftp
    function FtpSetCurrentDir(FtpFile: TWin32FindData): boolean;//Установка текущей директории на ftp-сервере
    function FtpOpen(Flags, Access: Cardinal): boolean;//Открытие ftp-файла
    function SendingRequest: boolean;// Посылает запросы и обрабатывает ошибки запросов
    function SendRequest: boolean;   // Посылка обычного запроса
    function SendRequestEx: boolean; // Посылка расширенного запроса (для заливки файлов методом PUT)
    function HttpDownload: boolean;  // Получение данных из инета
    function HttpUpload: boolean;    // Отправка данных на сервер
    function FtpDownload: boolean;   // Получение данных с ftp-сервера
    function FtpUpload: boolean;     // Отправка данных на ftp-сервер
    function InetDownload: boolean;  // Получение данных при помощи InternetOpenUrl
    procedure CloseHandles;          // Закрытие хендлов интернет-сессий
  protected
    procedure Execute; override;     // Выполнение потока
  public
    constructor Create(const AParameters: TParameters; AOnGiveMessage: TOnGiveMessage; AOwnerHandle: HWND);
    destructor Destroy; override;
  end;
//===============================================

//===== TInetDownloader =========================
  TInetDownloader = class(TComponent)
  private
    FAcceptTypes: string;                       //  Разрешенные типы получаемых данных
    FUserAgent: string;                         //  User Agent
    FUrl: string;                               //  Url файла, который нужно получить
    FAuthUserName: string;                      //  Имя пользователя для Autentification: Basic
    FAuthPassword: string;                      //  Пароль для Autentification: Basic
    FFileName: string;                          //  Имя файла, для сохранения или для отправки на сервер
    FRequestMethod: ShortString;                //  Тип запроса
    FPostType: TPostType;                       //  Способ отправки POST/Custom запроса
    FPostQuery: string;                         //  Строка POST/Custom запроса
    FPostHeaders: TStringList;                  //  POST/Custom-запрос в виде заголовков
    FReferer: string;                           //  Ссылка на Referer
    FProxy: string;                             //  Адрес прокси-сервера
    FProxyBypass: string;                       //  Адреса, для которых не нужно использовать прокси-сервер
    FProxyUserName: string;                     //  Имя пользователя для прокси
    FProxyPassword: string;                     //  Пароль для прокси
    FInternetAccessType: TInternetAccessType;   //  Тип доступа
    FReportLevel: TMsgTypes;                    //  Уровень выводимой информации
    FLoadFrom: Cardinal;                        //  Начальная позиция для скачивания/заливки, байт
    FLoadCount: Cardinal;                       //  Количество получаемых/передаваемых данных, байт
    FAutoFileName: boolean;                     //  Автоматически определять имя файла из Url
    FWaitOnWorkEnd: boolean;                    //  Ожидать завершения выполнения потока (!!!)В консольном приложении ОБЯЗАТЕЛЬНО должно быть TRUE иначе поток не будет выполнятся(!!!)
    FShowErrorDlg: boolean;                     //  Отображать InternetErrorDlg (Диалоги для ввода пороля и сертификата, как в IE)(В консольном приложении не используется)
    FRepeatOnError: boolean;                    //  Повторять закачку при ошибке связи/сервера
    FRepeatCount: byte;                         //  Количество повторов закачки
    FRepeatTimeout: Cardinal;                   //  Таймаут, после которого будет повтор закачки, мс
    FWriteMethod: TWriteMethod;                 //  Метод записи в файл
    FBufferSize: Cardinal;                      //  Размер буфера
    FSpeedLimit:Cardinal;                       //  Ограничение скорости, байт/с
    FOnGiveMessage: TOnGiveMessage;             //  Событие обработки посылаемого сообщения
    FOnDownloadFileDone: TOnDownloadFileDone;   //  Событие обработки завершения скачивания файла
    FOnDownloadStringDone: TOnDownloadStringDone;// Событие обработки завершения получения строки
    FOnDownloadStreamDone: TOnDownloadStreamDone;// Событие обработки завершения получения потока
    FOnUploadDone: TOnUploadDone;               //  Событие обработки завершения отправки данных
    FTypeOfData: TTypeOfData;                   //  Тип выходных данных (файл, строка, поток)
    FDownloadThread: TDownloadThread;           //  Экземпляр потока получения данных из инета
    FThreadsList: TThreadList;                  //  Список запущенных потоков

    FUploadingString: string;                   //  Передаваемая строка
    FUploadingStream: TStream;                  //  Передаваемый поток
    FDownloading: boolean;                      //  Определяет тип действия: True - скачивание данных, False - заливка данных на сервер

    FFtpThroughHttpProxy: boolean;              //  Работа с FTP через HTTP прокси-сервер
    FFtpPassive: boolean;                       //  Использовать пассивный режим работы FTP

    procedure SetUrl(const Value: string);      //  Процедура ввода свойства Url
    function  GetRequestMethod: TRequestMethod; //  Функция чтения свойства RequestMethod
    procedure SetRequestMethod(const Value: TRequestMethod);//Процедура ввода свойства RequestMethod
    procedure SetBufferSize(const Value: Cardinal);//Ввод размера буфера принимаемых данных
    procedure SetPostHeaders(const Value: TStringList);//Ввод PostHeaders
    function  GetWininetVersion: string;        //  Получение версии Wininet
    function  GetLocalIP: string;               //  Получение списка локальных IP

    procedure StartThread;                      //  Запуск потока скачивания
    procedure ThreadDone(Sender: TObject);      //  Обработчик завершения выполнения потока
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure DownloadFile;                     //  Получения данных в виде файла
    procedure DownloadString;                   //  Получение данных в виде строки
    procedure DownloadStream;                   //  Получение данных в виде потока
    procedure UploadFile;                       //  Заливка файла на сервер
    procedure UploadString(const Str: string);  //  Заливка данных в виде строки на сервер
    procedure UploadStream(const Stream: TStream);//Заливка данных в виде потока на сервер
    procedure Abort; overload;                  //  Отмена выполнения потока
    procedure Abort(Index: Integer); overload;  //  Отмена выполнения потока по его индексу в списке ThreadsList

    function SetCustomRequestMethod(const Value: ShortString): boolean;//Ввод пользовательского типа запроса
    function GetMaxConnsPerServer(out MaxConnsPer1_0Server, MaxConnsPerServer: Int64): boolean;//Получение разрешенного значения максимального количества соединений с одним сервером
    function SetMaxConnsPerServer(const MaxConnsPer1_0Server, MaxConnsPerServer: Cardinal): boolean;//Установка разрешенного значения максимального количества соединений с одним сервером

    property ThreadsList: TThreadList read FThreadsList;
  published
    //  == Свойства ==
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
    //  == События ==
    property OnGiveMessage: TOnGiveMessage read FOnGiveMessage write FOnGiveMessage;
    property OnDownloadFileDone: TOnDownloadFileDone read FOnDownloadFileDone write FOnDownloadFileDone;
    property OnDownloadStringDone: TOnDownloadStringDone read FOnDownloadStringDone write FOnDownloadStringDone;
    property OnDownloadStreamDone: TOnDownloadStreamDone read FOnDownloadStreamDone write FOnDownloadStreamDone;
    property OnUploadDone: TOnUploadDone read FOnUploadDone write FOnUploadDone;
  end;
//===============================================

procedure Register;

implementation

// Регистрация компонента на палитре 'Samples'
procedure Register;
begin
  RegisterComponents('Samples', [TInetDownloader]);
end;

//==========================================================
// TInetDownloader
//==========================================================
constructor TInetDownloader.Create(aOwner: TComponent);
begin
  //вызываем конструктор класса (aOwner - владелец компонента)
  inherited Create(aOwner);
  //Заполняем параметры дефолтными значениями
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
  if IsConsole then     //Для консольного приложения
    FWaitOnWorkEnd := True //свойство WaitOnWorkEnd должно быть True
  else
    FWaitOnWorkEnd := False;
  //Инициализация и заполнение первой строки в PostHeaders
  FPostHeaders := TStringList.Create;
  FPostHeaders.Add('Content-type: multipart/form-data, boundary=AaB03x542d');
  //Инициализируем список потоков (False - означает, что список НЕ БУДЕТ управлять выделением ресурсов для связанных объектов)
  FThreadsList := TThreadList.Create(False);
end;

destructor TInetDownloader.Destroy;
begin
  //Убираем связанные процедуры обработки (чтоб Access Violation не выскакивало)
  FOnGiveMessage        := nil;
  FOnDownloadFileDone   := nil;
  FOnDownloadStringDone := nil;
  FOnDownloadStreamDone := nil;
  //Освобождаем память, занятую PostHeaders
  FPostHeaders.Free;
  //Отменяем выполнение всех запущенных потоков
  while FThreadsList.Count <> 0 do
    Abort;
  //Освобождаем память, занятую списком потоков
  FThreadsList.Free;
  //Вызываем деструктор класса
  inherited Destroy;
end;

//  Процедура ввода свойства Url
procedure TInetDownloader.SetUrl(const Value: string);
{Value - проверяемое значение}
begin
  //Если юзер ввел ссылку без указания протокола
  if (Value <> '') and (Pos('://', Value) = 0) then
    FUrl := IIF(Pos('ftp.', LowerCase(Value)) = 1,//Если ссылка начинается с 'ftp.'
                'ftp://' + Value,  //считаем, что протокол 'ftp'
                'http://' + Value) //иначе считаем, что протокол 'http'
  else
    FUrl := Value;
end;

//Чтение свойства RequestMethod
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

//Получаем версию Wininet
function TInetDownloader.GetWininetVersion: string;
var
  RSize: Cardinal;
  Ver: INTERNET_VERSION_INFO;
begin
  //Пытаемся получить сведения о версии файла 'wininet.dll'
  Result := GetFileVersion(WININET_MODULE);
  //Если не удалось - получаем сведения с помощью INTERNET_OPTION_VERSION
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

//Получаем список локальных IP адресов
function TInetDownloader.GetLocalIP: string;
begin
  Result := Additional.GetLocalIP;
end;

//Ввод свойства RequestMethod
procedure TInetDownloader.SetRequestMethod(const Value: TRequestMethod);
{Value - проверяемое значение}
begin
  case Value of
    rmGet:    FRequestMethod := 'GET';
    rmPost:   FRequestMethod := 'POST';
    rmHead:   FRequestMethod := 'HEAD';
    rmCustom: FRequestMethod := '';
  end;
end;

//Ввод пользовательского значения свойства RequestMethod
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

//Получем значение максимального количества соединений с одним сервером
function TInetDownloader.GetMaxConnsPerServer(out MaxConnsPer1_0Server, MaxConnsPerServer: Int64): boolean;
{ MaxConnsPer1_0Server - максимальное количество подключений к HTTP/1.0 серверу
  MaxConnsPerServer - максимальное количество подключений к серверу
  Result - True, если получены оба значения
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

//Устанавливаем значение максимального количества соединений с одним сервером
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

//Ввод размера буфера принимаемых данных
procedure TInetDownloader.SetBufferSize(const Value: Cardinal);
{Value - проверяемое значение}
begin
    FBufferSize := FormatNumber(Value); //Буфер должен быть числом, кратным 16: 256, 512, 768, 1024...
end;

//Ввод PostHeaders
procedure TInetDownloader.SetPostHeaders(const Value: TStringList);
{Value - проверяемое значение}
begin
  FPostHeaders.Assign(Value);
end;

//Основная процедура для получения данных из инета
procedure TInetDownloader.DownloadFile;
begin
  FDownloading := True;
  //Если не заполнено имя файла и не стоит галка AutoFileName
  if (FFileName = '') and not FAutoFileName then
    begin
      //Выводим сообщение об ошибке и выходим
      if (Assigned(FOnGiveMessage)) then
        if ([mResult, mError] <= FReportLevel) then
          FOnGiveMessage(Self, [mResult, mError], MSG_NOT_FILL_FILENAME);
      Exit;
    end;
  FTypeOfData := odFile;//Тип получаемых данных - файл
  StartThread; //Запускаем поток скачивания
end;

//Процедура получения строки
procedure TInetDownloader.DownloadString;
begin
  FDownloading := True;
  FTypeOfData := odString;//Тип получаемых данных - строка
  StartThread; //Запускаем поток скачивания
end;

//Процедура получения потока
procedure TInetDownloader.DownloadStream;
begin
  FDownloading := True;
  FTypeOfData := odStream;//Тип получаемых данных - поток
  StartThread; //Запускаем поток скачивания
end;

//Процедура заливки файла на сервер
procedure TInetDownloader.UploadFile;
begin
  FDownloading := False;
  FTypeOfData := odFile;//Тип данных - файл
  StartThread; //Запускаем поток скачивания
end;

//Процедура заливки данных в виде строки на сервер
procedure TInetDownloader.UploadString(const Str: string);
begin
  FDownloading := False;
  FTypeOfData := odString;//Тип данных - строка
  FUploadingString := Str;
  StartThread; //Запускаем поток скачивания
end;

//Процедура заливки данных в виде потока на сервер
procedure TInetDownloader.UploadStream(const Stream: TStream);
begin
  FDownloading := False;
  FTypeOfData := odStream;//Тип данных - поток
  FUploadingStream := Stream;
  StartThread; //Запускаем поток скачивания
end;

//Запуск потока скачивания
procedure TInetDownloader.StartThread;
var Parameters: TParameters; //Набор параметров для скачивания
    Msg: TMsg;               //Используестся для подстановки в аналог Application.ProcessMessage
    Handle: HWND;            //Хендл объекта, на котором должно выводится InternetErrorDlg
begin
  //Если УРЛ не введено
  if FUrl = '' then
    begin
      //Выводим сообщение об ошибке и выходим
      if (Assigned(FOnGiveMessage)) then
        if ([mResult, mError] <= FReportLevel) then
          FOnGiveMessage(Self, [mResult, mError], MSG_NOT_FILL_URL);
      Exit;
    end;

  //Если не передается поток данных
  if ((FTypeOfData <> odStream) or FDownloading) then
    FUploadingStream := nil;//Убираем ссылку на поток

//====== Заполняем параметры скачивания =============
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
   if FShowErrorDlg then  //Если стоит галка ShowErrorDlg
     begin
       if IsConsole then  //Если приложение консольное
         Handle := GetDesktopWindow //то присваиваем хендл рабочего стола
       else
         Handle := FindWindow(PChar(String(GetOwner.ClassName)), nil);//иначе владельцем диалоговых окон будет форма, на которой лежит компонент
     end
   else //Если не стоит галка ShowErrorDlg
     Handle := 0; //Присваиваем неиспользуемый хендл (0)
  //Создаем экземпляр потока
  FDownloadThread := TDownloadThread.Create(Parameters,     //Параметры соединения
                                            FOnGiveMessage, //Процедура обработки сообщений потока
                                            Handle);        //Хендл формы для вывода InternetErrorDlg
  //Присваиваем ему обработчик завершения выполнения потока
  FDownloadThread.OnTerminate := ThreadDone;
  //Заносим созданный поток в список
  FThreadsList.Add(FDownloadThread);

  if FWaitOnWorkEnd then //Если стоит галка "WaitOnWorkEnd"
    begin
      if IsConsole then //Если используется в консольном приложении
        begin
          FDownloadThread.WaitFor;    //Юзаем метод потока и ждем до завершения
          FreeAndNil(FDownloadThread);//Освобождаем память, занимаемую потоком и удаляем ссылку на экземпляр потока
        end
      else //Если приложение оконное
        while FThreadsList.Count <> 0 do //Если у нас есть потоки
          //===Юзаем аналог Application.ProcessMessage====
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

//Процедура обработки завершения потока
procedure TInetDownloader.ThreadDone(Sender: TObject);
begin
  with (Sender as TDownloadThread) do
    begin
      if FTResult then //Если результат - успех
        begin
          //Формируеме сообщение об успешном завершении
          FTMessageType := [mResult, mOk];
          FTMessage := IIF(FDownloading,
                           MSG_DOWNOLOADING_DATA_OK,
                           MSG_UPLOADING_DATA_OK);
        end
      else //Иначе
        begin
          //Формируеме сообщение об ошибке
          FTMessageType := [mResult, mError];
          FTMessage := IIF(FDownloading,
                           MSG_DOWNOLOADING_DATA_ERROR,
                           MSG_UPLOADING_DATA_ERROR);
        end;
      //Отправляем сообщение
       if Assigned(FOnGiveMessage) and (FTMessageType <= FTParameters.ReportLevel) then
         //Синхронизация не требуется, т.к. поток уже завершен, сообщение отправляется напрямую
         FOnGiveMessage(Sender, FTMessageType, FTMessage);
      if FTParameters.Downloading then
        case FTParameters.TypeOfData of
          odString: //Если тип получаемых данных - строка
            if Assigned(FOnDownloadStringDone) then
              //Вызвать обработку процедуры завершения получения строки
              FOnDownloadStringDone(Sender, FTRecivedString, FTNeedDataSize, FTBytesReaded, FTResult);
          odFile:  //Если тип получаемых данных - файл
            if Assigned(FOnDownloadFileDone) then
              //Вызвать обработку процедуры завершения получения файла
              FOnDownloadFileDone(Sender, FTParameters.FileName, FTNeedDataSize, FTBytesReaded, FTResult);
          odStream: //Если тип получаемых данных - поток
            if Assigned(FOnDownloadStreamDone) then
              begin
                //Вызвать обработку процедуры завершения получения потока
                FOnDownloadStreamDone(Sender, FTRecivedStream, FTNeedDataSize, FTBytesReaded, FTResult);
              end
        end
      else
        if Assigned(FOnUploadDone) then
          begin
            //Вызвать обработку процедуры завершения отправки данных
            FOnUploadDone(Sender, FTParameters.Url, FTNeedDataSize, FTBytesReaded, FTResult);
          end
    end;
  //Удаляем поток из списка
  FThreadsList.Remove(TThread(Sender));
  //Очищаем ссылку на экземпляр потока
  FDownloadThread := nil;
end;

//Процедура отмены выполнения последнего запущенного потока
procedure TInetDownloader.Abort;
begin
  //Если есть запущенные потоки
  if FThreadsList.Count > 0 then
    //То выполняем Abort с параметром Index - равным последнему запущенному потоку
    Abort(FThreadsList.Count - 1);
end;

//Процедура отмены выполнения потока по его индексу в списке потоков
procedure TInetDownloader.Abort(Index: Integer);
var
  ADownloadThread: TDownloadThread;  //Экземпляр потока
begin
  //Получаем ссылку на экземпляр потока из списка по его индексу
  ADownloadThread := TDownloadThread(FThreadsList[Index]);
  //Удаляем полученный поток из списка
  FThreadsList.Delete(Index);
  //Если экземпляр потока существует
  if Assigned(ADownloadThread) then
    with ADownloadThread do
      begin
        //Результату присваивается значение "неудача"
        FTResult := False;
        //****Отправляется сообщение***
        FTMessageType := [mResult, mError];
        FTMessage := MSG_ABORT;
        if Assigned(FOnGiveMessage) and (FTMessageType <= FTParameters.ReportLevel) then
          //Т.к. поток будет разрушен, то сообщение отправляется
          //не процедуре синхронизации, а напрямую
          FOnGiveMessage(ADownloadThread, FTMessageType, FTMessage);
        //*****************************
        //Аварийное завершение потока
        CloseHandles;
        TerminateThread(Handle, 0);//(!!!)Может освобождать не все ресурсы(!!!)
        //Освобождение памяти, занимаемой потоком и очистка ссылки на экземпляр потока
        FreeAndNil(ADownloadThread);
      end;
end;

//==========================================================
// TDownloadThread
//==========================================================
constructor TDownloadThread.Create;
begin
  inherited Create(True);           // Создание потока в состоянии Suspensed
  Priority        := tpLower;       // Приоритет потока - низкий
  FreeOnTerminate := not IsConsole; // Для оконного приложения - True, для консоли - False, т.к. память освободим сами)
  FTResult        := False;         // Устанавливаем результат - неудача
  FTParameters    := AParameters;   // Получаем параметры,
  FTRecivedString := '';            // Очищаем выходную строку
  if FTParameters.TypeOfData = odStream then
    FTRecivedStream := TMemoryStream.Create;//Создаем поток данных для скачивания
  if Assigned(FTParameters.UploadingStream) then //Если поток данных определен
    begin
      FTUploadingStream := TMemoryStream.Create;//Создаем поток данных для отправки на сервер
      FTUploadingStream.LoadFromStream(FTParameters.UploadingStream);//загружаем его
    end;
  FTOnGiveMessage := AOnGiveMessage;// процедуру обработки сообщений
  FTOwnerHandle   := AOwnerHandle;  // и хендл родительского окна
  FTBytesReaded   := 0;             // \
  FTCurrentTime   := 0;             //   Обнуляем начальные значения
  FTUseOpenUrl    := False;         // /
  Resume;                           // Выводим поток из состояния Suspensed
end;

destructor TDownloadThread.Destroy;
begin
  //Убираем связанную процедуру (чтоб Access Violation не выскакивало)
  FTOnGiveMessage := nil;
  //Очищаем потоки данных
  FreeAndNil(FTRecivedStream);
  FreeAndNil(FTUploadingStream);
  //Закрываем открытые хендлы
  CloseHandles;
  //Вызываем деструктор класса
  inherited Destroy;
end;

//Процедура синхронизации с обработкой сообщений
procedure TDownloadThread.UpdateMessage;
begin
  if Assigned(FTOnGiveMessage) then
    FTOnGiveMessage(Self, FTMessageType, FTMessage)
end;

//Процедура выполнения потока
//Запускается автоматически, когда поток выводится в рабочее состояние
procedure TDownloadThread.Execute;
begin
  //Устанавливаем частоту таймера (если возможно)
  if not QueryPerformanceFrequency(Freq) then
    Freq := 0;
  //Выполняем парсинг урл
  if ParseUrl(FTParameters.Url, FTUrlStructure) then
    begin
      if FTUrlStructure.UserName <> '' then //Если в урл был указан логин
        begin //То заменяем AuthUserName и AuthPassword на логин/пароль, полученные из урл
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

//Получение времени
function TDownloadThread.GetTime: int64;
var
 Tick: int64;
begin
  if (Freq <> 0) and QueryPerformanceCounter(Tick) then
    Result := Tick
  else
    Result := GetTickCount;
end;

//Получение разницы между двумя значениями времени в мс
function TDownloadThread.GetTimeDiff(StartTime, FinishTime: int64): Cardinal;
begin
  if Freq <> 0 then
    Result := Round(Abs(StartTime - FinishTime) * 1000 / Freq)
  else
    Result := Abs(StartTime - FinishTime);
end;

procedure TDownloadThread.Delay(FromTime: int64; Delay: Cardinal);
{FromTime - время, от которого отсчитывать задержку
 Delay - задержка, мс
}
begin
  //Прокручиваем пустой цикл за время Delay
  while Delay > GetTimeDiff(FromTime, GetTime) do ;
end;

//Задание размера файла
function TDownloadThread.SetFileSize(const FileName: string; NewSize: Cardinal; CheckFile: boolean): boolean;
{FileName - имя файла
 Size - устанавливаемый размер
 CheckFile - проверка на соответствие размеров
}
var
  F: TFileStream; //Файловый поток
begin
  try
    //Если файл существует - открыть для записи, иначе - создать
    if FileExists(FileName) then
      F := TFileStream.Create(FileName, fmOpenWrite or fmShareDenyNone)
    else
      F := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
    try
      //Если проверка не включена или старый и новый размеры не совпадают
      if not CheckFile or (F.Size <> NewSize) then
        begin
          F.Size := 0; //Сделать файл нулевого размера (тогда при установке нового размера файл окажется заполнен NULL'ами)
          F.Size := NewSize; //Установить новый размер файла
        end;
      Result := True;
    finally
      F.Free;  //Освободить ресурсы
    end;
  except
    LastError := GetLastError;
    //**** В случае ошибки выдать предупреждение
    GetMessage(MSG_DOWNLOAD_FILE_ERROR, [FTParameters.FileName],
               [mMessage, mError], True);
    //****
    Result := False;;
  end;
end;

//Запись буфера данных в файл
function TDownloadThread.WriteFile(const FileName: string; Buf: PChar; BufLength: Cardinal; var WritePosition: Cardinal): boolean;
{FileName - имя записываемого файла
 Buf - буфер данных
 BufLength - размер буфера
 WritePosition - позиция записи в файл (если -1 - то записывается в конец файла)
}
var
  F: TFileStream; //Файловый поток
begin
  try
    //Если файл существует - открыть для записи, иначе - создать
    if FileExists(FileName) then
      F := TFileStream.Create(FileName, fmOpenWrite or fmShareDenyNone)
    else
      F := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
    try
      //Установить позицию записи
      F.Position := IIF(WritePosition = DWORD(-1), //Если WritePosition равна -1
                        F.Size,                    //То устанавливаем указатель на конец файла
                        WritePosition);            //Иначе положение указателя определяется WritePosition
      F.Write(Buf^, BufLength);  //Записать буфер в файл
      if WritePosition <> DWORD(-1) then //Если WritePosition не равна -1
        Inc(WritePosition, BufLength);   //То увеличить WritePosition на размер записанных данных
      Result := True;
    finally
      F.Free;  //Освободить ресурсы
    end;
  except
    LastError := GetLastError;
    //**** В случае ошибки выдать предупреждение
    GetMessage(MSG_DOWNLOAD_FILE_ERROR, [FTParameters.FileName],
               [mMessage, mError], True);
    //****
    Result := False;
  end;
end;

//Чтение файла в буфер
function TDownloadThread.ReadFile(const FileName: string; out Buf: PChar; BufLength: Cardinal; ReadPosition: Cardinal): Cardinal;
{FileName - имя считываемого файла
 Buf - буфер данных
 BufLength - размер буфера
 ReadPosition - позиция чтения файла
 Result - размер прочитанных данных, байт
}
var
  F: TFileStream; //Файловый поток
begin
  Result := 0;
  try
    //Открыть файл для чтения
    F := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
      //Установить позицию чтения
      F.Position := ReadPosition;
      Result := F.Read(Buf^, BufLength);  //Считать данные из файла в буфер, определить размер считанных данных
    finally
      F.Free;  //Освободить ресурсы
    end;
  except
    LastError := GetLastError;
    //**** В случае ошибки выдать предупреждение
    GetMessage(MSG_READ_FILE_ERROR, [FTParameters.FileName],
               [mMessage, mError], True);
    //****
  end;
end;

//Получение скорости соединения
function TDownloadThread.GetSpeed(Bytes: Cardinal; PrevTime, CurrTime: int64): Cardinal;
{ Bytes - количество скачанных/отправленных данных, байт
  PrevTime - начальное значение времени
  Result - скорость соединения, байт/с
}
var
  dTime: Cardinal;   //Хранит разницу между текущим и начальным временем, мс
  Shift: Cardinal;   //Смещение, сек (требуется для ограничения скорости)
begin
  //Получаем разницу времени в мс
  dTime := GetTimeDiff(PrevTime, CurrTime);
  if dTime > 0 then
    Result := Round((Bytes / dTime * 1000))//Определяем скорость
  else
    Result := 0;
  //Если установлен лимит скорости и скорость его превышает
  if (FTParameters.SpeedLimit <> 0) and (Result > FTParameters.SpeedLimit) then
    begin
      //Расчитываем смещение
      Shift := Round(dTime * ((Result / FTParameters.SpeedLimit) - 1) * 1000);
      //Ожидаем заданное время
      Delay(CurrTime, Shift);
      //Повторно определяем скорость
      Result := GetSpeed(Bytes, PrevTime, CurrTime);
    end;
end;

//Подготавливаем сообщение для вывода
procedure TDownloadThread.GetMessage(FormatMsg: string; Args: array of TVarRec; MsgTypes: TMsgTypes; Error: boolean);
{Msg - Текст сообщения
 MsgTypes - Тип сообщения
}
var
  ErrMsg: string;
  ErrCode: Cardinal;
begin
  ErrCode := 0;
  if MsgTypes <= FTParameters.ReportLevel then //Проверяем соответствие уровню выводимой информации
    begin
      FTMessageType := MsgTypes;               //Устанавливаем тип сообщения
      FTMessage := Format(FormatMsg, Args);    //Задаем строку сообщения
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
      Synchronize(UpdateMessage);            //Синхронизируем с процедурой вывода сообщений
    end;
end;

//Функция получения дополнительной информации об ошибках
function TDownloadThread.GetLastResponseInfo(var Error: Cardinal): string;
var
  RSize: Cardinal; //Нужно для получения размера
  PErrorInfo: PChar; //Содержит информацию, полученную от запроса
begin
  Result := ''; //Очищаем результат
  RSize := 0;   //Устанавливаем размер равным 0, тогда при первом вызове HttpQueryInfo, в него будет записан требуемый размер
  InternetGetLastResponseInfo(Error,
                              PErrorInfo,
                              RSize); //Сейчас в RSize записывается требуемый размер
  if RSize > 0 then begin
    PErrorInfo := StrAlloc(RSize); //Выделяем память нужного размера
    try
      if InternetGetLastResponseInfo(Error,
                                     PErrorInfo, //Сейчас в переменную записывается полученная инфа
                                     RSize)
      then begin
        //Очищаем завершение строки от непечатаемых символов и точки
        while (RSize > 0) and (PErrorInfo[RSize - 1] in [#0..#32, '.']) do Dec(RSize);
        //Задаем выходную строку нужного размера
        SetString(Result, PErrorInfo, RSize);
      end;
    finally
      StrDispose(PErrorInfo); //Освобождаем память, выделенную под строку
    end;
  end;
end;


// Процедура парсинга Url
// <схема>://<логин>:<пароль>@<хост>:<порт>/<Url-путь>
function TDownloadThread.ParseUrl(const Url: String; out UrlStructure: TUrlStructure): boolean;
var
  AUrlStructure: URL_COMPONENTS;//Временная структура Url
  Flags: Cardinal; //Флаги для разбивки строки Url в структуру
begin
  Result := False;
  //Устанавливаем флаги
  Flags := 0;
  //Очищаем структуру от мусорных данных
  ZeroMemory(@AUrlStructure, SizeOf(AUrlStructure));
  ZeroMemory(@UrlStructure, SizeOf(UrlStructure));

  with AUrlStructure do begin
    //---Устанавливаем начальные значения структуры---
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

    //Разбиваем строку Url на составляющие
    if InternetCrackUrl(PChar(Url), Length(Url), Flags, AUrlStructure) then
      with UrlStructure do
        begin
          //---Заносим полученные значения в UrlStructure---
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
        //***В случае ошибки выдаем предупреждение***
        GetMessage(MSG_URL_ERROR, [],
                   [mMessage, mError], True);
        //******
      end;
  end;
end;

procedure TDownloadThread.SetLoadParameters;
begin
  //Определяем параметры скачивания
  if FTParameters.LoadCount = 0 then
    begin
      if FTParameters.LoadFrom <= FTDataSize then
        FTNeedDataSize := FTDataSize - FTParameters.LoadFrom
      else
        FTNeedDataSize := 0;
    end
  else
    begin
      //Если размер данных определен и пользователь запросил количество данных, превышающее доступное
      if FTParameters.LoadFrom + FTParameters.LoadCount > FTDataSize then
        begin
          if FTParameters.LoadFrom < FTDataSize then //Если начальная позиция чтения меньше чем доступные данные
            //То уменьшаем количество доступных данных, до максимально возможного
            FTParameters.LoadCount := FTDataSize - FTParameters.LoadFrom
          else //Иначе, ставим 0
            FTParameters.LoadCount := 0;
        end;
        FTNeedDataSize := FTParameters.LoadCount;
    end;
end;

//Получение кода ответа сервера
function TDownloadThread.GetStatusCode(var StatusCode: Cardinal): boolean;
{hRequest - хендл запроса, от которого нужно получить инфу
 StatusCode - возвращает код ответа сервера
}
var
  RSize: Cardinal; //Нужно для получения размера
  dwIndex: Cardinal; //Для подстановки в HttpQueryInfo в качестве зарезервированной переменной
begin
  RSize := 4;  //Размер получаемых данных (для DWORD должно равнятся 4)
  dwIndex := 0;
  Result := HttpQueryInfo(hRequest,
                          HTTP_QUERY_STATUS_CODE or//Флаги: Получить код ответа сервера
                          HTTP_QUERY_FLAG_NUMBER,  //В числовом виде
                          @StatusCode,             //Указатель на переменную, в которую запишется результат
                          RSize,                   //Размер
                          dwIndex);                //Зарезервированная переменная
end;

//Функция получения информации от запроса
function TDownloadThread.GetQueryInfo(dwInfoLevel: Cardinal): string;
{dwInfoLevel - флаги, определяющие какую инфу нужно получить
}
var
  RSize: Cardinal; //Нужно для получения размера
  PQueryInfo: PChar; //Содержит информацию, полученную от запроса
  dwIndex: Cardinal; //Для подстановки в HttpQueryInfo в качестве зарезервированной переменной
begin
  Result := ''; //Очищаем результат
  RSize := 0;   //Устанавливаем размер равным 0, тогда при первом вызове HttpQueryInfo, в него будет записан требуемый размер
  dwIndex := 0;
  HttpQueryInfo(hRequest,
                dwInfoLevel,
                PQueryInfo,
                RSize, //Сейчас в RSize записывается требуемый размер
                dwIndex);
  if RSize > 0 then begin
    PQueryInfo := StrAlloc(RSize); //Выделяем память нужного размера
    try
      if HttpQueryInfo(hRequest,
                       dwInfoLevel,
                       PQueryInfo, //Сейчас в переменную записывается полученная инфа
                       RSize,
                       dwIndex)
      then begin
        //Очищаем завершение строки от непечатаемых символов и точки
        while (RSize > 0) and (PQueryInfo[RSize - 1] in [#0..#32, '.']) do Dec(RSize);
        //Задаем выходную строку нужного размера
        SetString(Result, PQueryInfo, RSize);
      end;
    finally
      StrDispose(PQueryInfo); //Освобождаем память, выделенную под строку
    end;
  end;
end;

//Получение сведений из параметров
function TDownloadThread.GetQueryOptions(dwInfoLevel: Cardinal): string;
{dwInfoLevel - флаги, определяющие какую инфу нужно получить
}
var
  RSize: Cardinal; //Нужно для получения размера
  PQueryOptions: PChar; //Содержит информацию, полученную от запроса
begin
  Result := ''; //Очищаем результат
  RSize := 0;   //Устанавливаем размер равным 0, тогда при первом вызове HttpQueryInfo, в него будет записан требуемый размер
  InternetQueryOption(hRequest,
                      dwInfoLevel,
                      PQueryOptions,
                      RSize); //Сейчас в RSize записывается требуемый размер
  if RSize > 0 then begin
    PQueryOptions := StrAlloc(RSize); //Выделяем память нужного размера
    try
      if InternetQueryOption(hRequest,
                             dwInfoLevel,
                             PQueryOptions, //Сейчас в переменную записывается полученная инфа
                             RSize)
      then begin
        //Очищаем завершение строки от непечатаемых символов и точки
        while (RSize > 0) and (PQueryOptions[RSize - 1] in [#0..#32, '.']) do Dec(RSize);
        //Задаем выходную строку нужного размера
        SetString(Result, PQueryOptions, RSize);
      end;
    finally
      StrDispose(PQueryOptions); //Освобождаем память, выделенную под строку
    end;
  end;
end;

//Функция получения размера данных
function TDownloadThread.GetDataSize: Cardinal;
{hRequest - хендл запроса, от которого нужно получить инфу
}
var
  RSize: Cardinal; //Нужно для получения размера
  dwIndex: Cardinal; //Для подстановки в HttpQueryInfo в качестве зарезервированной переменной
begin
  //Пытаемся получить размер файла переходом в его конец
  Result := InternetSetFilePointer(hRequest,
                                   0,        //Смещение - 0
                                   nil,
                                   FILE_END, //Относительно конца файла
                                   0);
  if Result = DWORD(-1) then //Если не получилось
    begin
      Result := 0;
      RSize := 4;  //Размер получаемых данных (для DWORD должно равнятся 4)
      dwIndex := 0;
      //Пытаемся определить размер файла с помощью HttpQueryInfo
      HttpQueryInfo(hRequest,
                    HTTP_QUERY_CONTENT_LENGTH or //Флаги: Получить размер содержимого
                    HTTP_QUERY_FLAG_NUMBER,      //В числовом виде
                    @Result,
                    RSize,
                    dwIndex);
    end;
end;

//Функция получения типа хендла
function TDownloadThread.GetHandleType: Cardinal;
{hConnect - хендл соединения, от которого нужно получить инфу
}
var
  dwRes: Cardinal; //Результат выполнения
  RSize: Cardinal; //Нужно для получения размера
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
      //**** Если не удалось создать соединение выдаем сообщение
      GetMessage('Страшный ошибка', [],
                 [mMessage, mError], True);
    Result := 0;
    end;
end;

//Функция получения имени файла
function TDownloadThread.GetFileName: string;
{hRequest - хендл запроса, от которого нужно получить инфу
}
var
  i: integer;
  tempStr: string;
begin
  Result := ''; //Очищаем результат
  //Если был отправлен HTTP запрос
  if ((GetHandleType = INTERNET_HANDLE_TYPE_HTTP_REQUEST) or (GetHandleType = INTERNET_HANDLE_TYPE_CONNECT_HTTP)) then
    begin
      //Пытаемся получить имя файла с помощью HttpQueryInfo
      tempStr := GetQueryInfo(HTTP_QUERY_CONTENT_DISPOSITION);
      i := Pos('filename=', tempStr);
      if i <> 0 then //Если в полученной информации содержится имя файла
        begin
          Delete(tempStr, 1, i + 8); //8 = (Length('filename=') - 1)
          i := Pos(';', tempStr);
          //То результату присваиваем его
          if i <> 0 then
            Result := AnsiDequotedStr(Copy(tempStr, 1, i), '"')
          else
            Result := AnsiDequotedStr(Copy(tempStr, 1, Length(tempStr)), '"');
        end;
    end;

  if Result = '' then //Если же нет
    begin
      //Получаем имя файла из Url
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

      //Получаем инфу о типе содержимого
      tempStr := GetQueryInfo(HTTP_QUERY_CONTENT_TYPE);
      if tempStr <> '' then //Если инфу получили, то разбираем результат
        begin
          i := Pos(';', tempStr);
          if i <> 0 then
            Delete(tempStr, i, Length(tempStr));
          //Меняем расширение файла в соответствии с типом
          //Текст
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
          //Графика
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
          //Аудио
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
          //Видео
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
          //Архив
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
          //Прочие
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
  //В случае необходимости декодируем имя файла из Url-формата в нормальный вид
  if Pos('%', Result) <> 0 then
    Result := UrlDecode(Result);
end;

//Функция получения порции данных из инета
function TDownloadThread.GetInetData(Buffer: Pointer; SizeOfBuffer: Cardinal; var BufferLen: Cardinal; var NumOfRepeat: byte): byte;
{hRequest - хендл запроса
 Buffer - указатель на буфер для получения данных
 SizeOfBuffer - размер буфера
 BufferLen - возвращает количество прочитанных байт в этой итерации
 NumOfRepeat - возвращает количество повторов при ошибках связи/сервера
 Result:
 0 - Продолжить работу цикла дальше
 1 - Перейти к новой итерации цикла без выполнения последующего кода
 2 - Невозможно продолжить получение данных, прием данных будет повторен с начала
 3 - Остановить работу цикла, результат - успех
 4 - Остановить работу цикла, результат - неудача
}
var
  StatusCode: Cardinal;
begin
  if not InternetReadFile(hRequest, Buffer, SizeOfBuffer, BufferLen) or //Если не удается прочитать данные из инета
     ((BufferLen = 0) and (FTBytesReaded = 0))                          //Или данные прочитаны, но пусты
  then
    begin
      if FTParameters.RepeatOnError then   //Если стоит галка RepeatOnError
        if (FTParameters.RepeatCount = 0) or (NumOfRepeat < FTParameters.RepeatCount) then //И количество повторов меньше ограничения (0 - неограниченно)
          if ((FTParameters.LoadCount <> 0) and (FTBytesReaded < FTParameters.LoadCount)) or //Если задано LoadCount и скачано меньше требуемого
             ((FTParameters.LoadCount = 0) and (FTBytesReaded < FTDataSize))                     //Или если LoadCount = 0 (неограниченно) и скаченно меньше размера файла
          then
            begin
              Inc(NumOfRepeat); //Увеличить заначение количества повторов
              //**** Выдать сообщение об ошибке загрузке
              GetMessage(MSG_DOWNLOAD_ERROR, [NumOfRepeat, FTParameters.RepeatTimeout],
                         [mMessage, mInfo], False);
              //****

              //Ждем время, указанное в RepeatTimeout
              Delay(GetTime, FTParameters.RepeatTimeout);

              if FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP then
                begin
                  Result := 2; //Результат - начать скачивание сначала
                  Exit;
                end;

              //Повторить посылку запроса
              SendingRequest;
              //Получить код ответа сервера
              if GetStatusCode(StatusCode) then
                if StatusCode = HTTP_STATUS_OK then
                  if (FTDataSize = 0) or  //Если размер файла не удалось определить
                     (InternetSetFilePointer(hRequest,
                                             FTParameters.LoadFrom + FTBytesReaded, //Смещение: Откуда начиналось скачивание + количество скачанных данных
                                             nil,
                                             FILE_BEGIN,                                //Относительно начала файла
                                             0)
                      = DWORD(-1)) //Или не получилось сместится до нужной позиции в интернет-файле
                  then
                    begin
                      Result := 2; //Результат - начать скачивание сначала
                      Exit;
                    end;
              Result := 1; //Результат - перейти к новой итерации
              Exit;
            end;
      Result := 4; //Результат - выполнение закончилось неудачей
      Exit;
    end;
  //Если количество прочитанных данных больше требуемого, то ограничить его требуемым
  if (FTParameters.LoadCount <> 0) and ((FTBytesReaded + BufferLen) > FTParameters.LoadCount) then
    BufferLen := FTParameters.LoadCount - FTBytesReaded;
  Result := IIF(BufferLen = 0,//Если нет больше доступных для чтения данных
                3,            //Результат - выполнение успешно завершилось
                0);           //Иначе, результат - продолжить выполнение
end;

//Получаем нужные заголовки из параметров
procedure TDownloadThread.GetHeaders(out Headers: PChar; out Optional: PChar);
begin
  //Если запрос GET, HEAD или запрос без тела сообщения
  if (FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'HEAD') or (FTParameters.PostType = ptNone) then
    begin
      //То хеадеры не нужны
      Headers := nil;
      Optional := nil;
    end
  else
    //Если используется запрос с заголовками и список заголовков не пуст
    if (FTParameters.PostType = ptHeaders) and (FTParameters.PostHeaders.Count <> 0) then
      begin
        //Получаем определяющий заголовок из первой строки
        StrHeaders := FTParameters.PostHeaders.Strings[0];
        //Получаем остальные заголовки
        StrOptional := FTParameters.PostHeaders.GetText;
        StrOptional := (Copy(StrOptional,
                             Length(StrHeaders) + 1 + Length(LNBR),//Убираем первую строку вместе с символами завершения
                             Length(StrOptional) - Length(StrHeaders) - 2 - Length(LNBR))//Убираем символы завершения строки в конце
                        );
        if StrHeaders = '' then Headers := nil
          else Headers := PChar(StrHeaders);
        if StrOptional = '' then Optional := nil
          else Optional := PChar(StrOptional);
      end
    else
      begin
        //иначе получаем заголовки из строки
        Headers := 'Content-Type: application/x-www-form-urlencoded';
        Optional := PChar(FTParameters.PostQuery);
      end;
end;

//Открываем сессию
function TDownloadThread.InetOpen(Flags: Cardinal): boolean;
begin
  hSession := InternetOpen(PChar(FTParameters.UserAgent),  //User Agent
                           FTParameters.InternetAccessType,//Тип доступа
                           PChar(FTParameters.Proxy),      //Адрес прокси сервера
                           PChar(FTParameters.ProxyBypass),//Адреса, для которых не нужно использование прокси
                           Flags);                         //Флаги
  if Assigned(hSession) then
    begin
      //**** Если удалось открыть сессию выдаем сообщение
      GetMessage(MSG_INTERNET_OPEN_OK, [],
                 [mMessage, mOk], False);
      //****
      Result := True;
    end
  else
    begin
      Result := False;
      LastError := GetLastError;
      //**** Если не удалось открыть сессию выдаем сообщение
      GetMessage(MSG_INTERNET_OPEN_ERROR, [],
                 [mMessage, mError], True);
      //****
    end;
end;

//Создаем соединение
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
  hConnect := InternetConnect(hSession,                        //Хендл открытой сессии
                              PChar(FTUrlStructure.Host),      //Хост
                              FTUrlStructure.Port,             //Порт
                              PChar(FTParameters.AuthUserName),//Логин для доступа к хосту
                              PChar(FTParameters.AuthPassword),//Пароль для доступа к хосту
                              Service,                         //Используемый сервис
                              Flags,                           //Флаги
                              0);
  if Assigned(hConnect) then
    begin
      //**** Если удалось создать соединение выдаем сообщение
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
      //**** Если не удалось создать соединение выдаем сообщение
      GetMessage(MSG_INTERNET_CONNECT_ERROR, [FTUrlStructure.Host],
                 [mMessage, mError], True);
      if (LastError <> ERROR_INTERNET_EXTENDED_ERROR) and (FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP) then
        GetMessage(MSG_SERVER_ANSVER, [GetLastResponseInfo(LastError)],
                   [mMessage, mInfo], False);
      //****
    end;
end;

//Соединение для FTP через HTTP-прокси и GOPHER
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
  Headers: PChar;//Определяющий заголовок
  Optional: PChar;//Остальные заголовки
  Ansver: string;
begin
  //Получаем нужные заголовки
  GetHeaders(Headers, Optional);
  if (Headers <> nil) and (Optional <> nil) then
    Headers := PChar(Headers + LNBR + Optional);
  hConnect := InternetOpenUrl(hSession,         //Хеадер сессии, открытой InternetOpen
                              PChar(CreateUrl), //Путь к файлу
                              Headers,          //Заголовки запроса
                              Length(Headers),  //Размер заголовков запроса
                              Flags,            //Флаги
                              0);               //Контекст
  if Assigned(hConnect) then
    begin
      hRequest := hConnect;
      //**** Если удалось открыть сессию выдаем сообщение
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
      //**** Если не удалось открыть сессию выдаем сообщение
      GetMessage(MSG_INTERNET_CONNECT_ERROR, [FTParameters.Url],
                 [mMessage, mError], True);
      if (LastError <> ERROR_INTERNET_EXTENDED_ERROR) and (FTUrlStructure.NumScheme = INTERNET_SCHEME_FTP) then
        GetMessage(MSG_SERVER_ANSVER, [GetLastResponseInfo(LastError)],
                   [mMessage, mInfo], False);
      //****
    end;
end;

//Создаем запрос
function TDownloadThread.OpenRequest(Flags: Cardinal): boolean;
begin
  hRequest := HttpOpenRequest(hConnect,                         //Хендл открытого соединения
                              PChar(FTParameters.RequestMethod),//Тип запроса
                              PChar(FTUrlStructure.UrlPath + FTUrlStructure.ExtraInfo),//Путь урл + строка запроса
                              HTTP_VERSION,//HTTP/1.0           //Версия
                              PChar(FTParameters.Referer),      //Referer
                              @FTParameters.AcceptTypes,        //Доступные типы данных
                              Flags,                            //Флаги
                              0);
  if Assigned(hRequest) then
    begin
      //**** Если удалось создать запрос выдаем сообщение
      GetMessage(MSG_OPEN_REQUEST_OK, [FTParameters.RequestMethod],
                 [mMessage, mOk], False);
      //****
      Result := True;
    end
  else
    begin
      Result := False;
      LastError := GetLastError;
      //**** Если не удалось создать запрос выдаем сообщение
      GetMessage(MSG_OPEN_REQUEST_ERROR, [FTParameters.RequestMethod],
                 [mMessage, mError], True);
      //****
    end;
end;

//Находим ftp-файл
function TDownloadThread.FtpFindFile(Flags:Cardinal; var FtpFile: TWin32FindData):boolean;
{Flags - флаги
 FtpFile - структура, содержащая сведения о файле
}
begin
  hRequest := FtpFindFirstFile(hConnect,
                               PChar(FTUrlStructure.UrlPath),
                               FtpFile,
                               Flags,
                               0);
  if Assigned(hRequest) then
    begin
      //**** Если удалось открыть файл выдаем сообщение
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
      //**** Если не удалось открыть файл выдаем сообщение
      GetMessage(MSG_FTP_FIND_FILE_ERROR, [FTUrlStructure.UrlPath],
                 [mMessage, mError], True);
      //****
    end;
end;

function TDownloadThread.FtpSendCommand(const FtpCommandStr: string; var Ansver: string): boolean;
var
  ExpectResponse: boolean;//Запрос данных
  IsWrite: boolean;//Признак записи данных
  ErrCode: Cardinal;
begin
  Result := False;

  //Если была отправленна команда записи файла
  if ((Pos('APPE', UpperCase(FtpCommandStr)) = 1) or
      (Pos('STOR', UpperCase(FtpCommandStr)) = 1) or
      (Pos('STOU', UpperCase(FtpCommandStr)) = 1)) then
    begin
      //Отправляем комманду с запросом данных
      ExpectResponse := True;
      IsWrite := True;
    end
  else
    begin
      //Отправляем комманду без запроса данных
      ExpectResponse := False;
      IsWrite := False;
    end;
  if not FtpCommand(hConnect,                          //Хеадер InternetConnect
                    ExpectResponse,                    //Возвращать ответ
                    FTP_TRANSFER_TYPE_BINARY,          //Флаг, определяющий тип возвращаемого ответа
                    PChar(FtpCommandStr),              //Команда FTP (список можно посмотреть там: http://www.nsftools.com/tips/RawFTP.htm)
                    0,                                 //Контекст (для асинхронного режима)
                    hRequest)                          //Хеадер, с которого InternetReadFile будет читать возвращенные данные
  then
    begin //Если комманда не отправилась
      LastError := GetLastError;
      ExpectResponse := True;
      Ansver := GetLastResponseInfo(ErrCode);
      //Парсим ответ сервера на ошибку "425" и при наличии таковой
      if not ((Pos('425', Ansver) = 1) and
        //переотправляем комманду с запросом данных
        FtpCommand(hConnect,
                   ExpectResponse,
                   FTP_TRANSFER_TYPE_BINARY,//FTP_TRANSFER_TYPE_ASCII
                   PChar(FtpCommandStr),
                   0,
                   hRequest))
        then begin
          Ansver := GetLastResponseInfo(ErrCode);
          //*** Если не удалось, выдаем сообщение ***
          GetMessage(MSG_FTP_COMMAND_ERROR, [FtpCommandStr],
                     [mMessage, mError], True);
          //*******
          Exit;//И выходим
        end;
    end;
  //*** Если удалось, выдаем сообщение ***
  Ansver := GetLastResponseInfo(ErrCode);
  GetMessage(MSG_FTP_COMMAND_OK, [FtpCommandStr, Ansver],
             [mMessage, mOk], False);
  //И, при необходимости, получаем данные
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
  FtpCommandStr: string;//Строка команды FTP
  Headers, Optional: PChar;//Полученные заголовки
  Ansver: string;

  i: integer;
begin
  i := 0;

  //Получаем строку комманды
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

//Открываем ftp-файл
function TDownloadThread.FtpOpen(Flags, Access: Cardinal): boolean;
{Flags - флаги
 Access - тип доступа: GENERIC_READ или GENERIC_WRITE (но не оба вместе!)
}
begin
  hRequest := FtpOpenFile(hConnect,                         //Хендл открытого соединения
                          PChar(FTUrlStructure.UrlPath),    //Путь к файлу
                          Access,                           //Тип доступа
                          Flags,                            //Флаги
                          0);
  if Assigned(hRequest) then
    begin
      //**** Если удалось открыть файл выдаем сообщение
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
      //**** Если не удалось открыть файл выдаем сообщение
      LastError := GetLastError;
      GetMessage(MSG_OPEN_FTP_ERROR, [FTUrlStructure.UrlPath],
                 [mMessage, mError], True);
      //****
    end;
end;

//Функция отправки запроса и контроля ошибок
function TDownloadThread.SendingRequest: boolean;
var
  StatusCode: Cardinal;
  Send: boolean; //Результат отправки запроса

  dwFlags: Cardinal; //Флаги для InternetOpenUrl
begin
  Result := False;
  if FTUseOpenUrl then
    begin
      //Заполняем флаги: Не использовать кеш для загрузки файла, поддерживать соединение (нужно, чтоб не вводить повторно логин/пароль), использовать существующее соединение
      dwFlags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT or INTERNET_FLAG_RELOAD;
      //Добавить флаг: Использовать пассивный режим FTP
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
      //**** Если удалось отправить запрос выдаем сообщение
      GetMessage(MSG_SEND_REQUEST_OK, [],
                 [mMessage, mOk], False);
      //****
    end
  else //Если отправить запрос не удалось - выходим
    Exit;

  dwFlags := GetHandleType;
  if ((dwFlags = INTERNET_HANDLE_TYPE_HTTP_REQUEST) or (dwFlags = INTERNET_HANDLE_TYPE_CONNECT_HTTP)) then
    begin
      //Получаем код ответа сервера
      if not GetStatusCode(StatusCode) then
        begin
          LastError := GetLastError;
          //**** Если не удалось получить код ответа сервера, выдаем сообщение
          GetMessage(MSG_QUERY_INFO_ERROR, [],
                     [mMessage, mError], True);
          //****
            Exit; //И выходим
        end;
      //Если код ответа - требуется авторизация прокси
      if StatusCode = HTTP_STATUS_PROXY_AUTH_REQ then
        SetProxyAuth(StatusCode);
      //Пока ответ сервера не будет - ОК
      while StatusCode >= HTTP_STATUS_AMBIGUOUS{300} do
        begin
          if not GetErrorDlg(StatusCode, True) then
            begin
              if StatusCode <> 0 then
                GetMessage(MSG_QUERY_INFO_HTTP, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                          [mResult, mInfo], False);
              //Получаем ответ сервера
              InetReadFile;
              Exit;//и выходим
            end
        end;
    end;
  Result := True
end;

//Отправляем запрос
function TDownloadThread.SendRequest: boolean;
var
  Headers: PChar;//Определяющий заголовок
  Optional: PChar;//Остальные заголовки
  StatusCode: Cardinal;
begin
  //Получаем нужные заголовки
  GetHeaders(Headers, Optional);
  //Отправляем их со строкой запроса
  Result := HttpSendRequest(hRequest, Headers, Length(Headers), Optional, Length(Optional));

  if not Result then
    Result := GetErrorDlg(StatusCode, False);
end;

//Оправка расщиренного запроса (для заливки файла на сервер методом PUT)
function TDownloadThread.SendRequestEx: boolean;
var
  InternetBuf : INTERNET_BUFFERS;//Интернет-буфер для передачи в HTTPsendRequestEX
  StatusCode: Cardinal;
begin
  Result := False;

  SetLoadParameters;

  //Заполняем структуру InternetBuf
  ZeroMemory(@InternetBuf, SizeOf(InternetBuf));
  InternetBuf.dwStructSize := SizeOf(InternetBuf);
  InternetBuf.dwBufferTotal := FTNeedDataSize;

  //Посылаем запрос
  if not HttpSendRequestEX(hRequest, @InternetBuf, nil, HSR_INITIATE, 0) then //HSR_INITIATE - означает, что операция будет завершена только после посылки HttpEndRequest
    begin
      LastError := GetLastError;
      //**** Если не удалось отправить запрос, выдаем сообщение
      GetMessage(MSG_SEND_REQUEST_ERROR, [],
                 [mMessage, mError], True);
      //****
      Exit; //И выходим
    end
  else
    if not InetWriteFile then
      Exit;
  //Завершаем отправку запроса
  Result := HttpEndRequest(hRequest, nil, 0, 0);

  //Если требуется повтор запроса, повторяем
  if GetLastError = ERROR_INTERNET_FORCE_RETRY then
    Result := SendRequestEx;

  if not Result then
    Result := GetErrorDlg(StatusCode, False);
end;

//Процедура аутентификации в прокси
function TDownloadThread.SetProxyAuth(var StatusCode: Cardinal): boolean;
begin
  Result := False;
  //Вводим логин/пароль для прокси
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
    //И переотправляем запрос
    if FTParameters.Downloading or FTUseOpenUrl then
      SendRequest
    else
      SendRequestEx;
  Result := GetStatusCode(StatusCode);
end;

//Процедура вызова InternetErrorDlg
function TDownloadThread.GetErrorDlg(var StatusCode: Cardinal; Auth: boolean): boolean;
var
  Data: pointer; //Указатель, нужен для подстановки в InternetErrorDlg
begin
  Data := nil;
  Result := False;
  //Пытатся вызвать InternetErrorDlg
  case InternetErrorDlg(FTOwnerHandle,                       //Хендл окна, в котором будет создаваться диалог
                        hRequest,                            //Хендл запроса
                        LastError,                           //Код ошибки
                        FLAGS_ERROR_UI_FILTER_FOR_ERRORS or  //Флаги: Сканировать хендлы для поиска скрытых ошибок, не указанных в Коде ошибки
                        FLAGS_ERROR_UI_FLAGS_GENERATE_DATA or//Запрашивать нужные данные из хендла (будут сохранены в Data)
                        FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS, //Сохранять результат вызова диалога в хендле
                        Data)
  of
    ERROR_SUCCESS:   begin{0} //Когда юзер жмет отмену, при диалоге аутентификации, или когда жмет ОК, при диалоге получения сертификата (ппц логичное поведение, мелкософт как всегда отличились)
                       if Auth then
                         //**** Формируем сообщение с текстом ответа сервера
                         GetMessage(MSG_QUERY_INFO_HTTP_ERROR, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                                    [mMessage, mError], False)
                         //****
                       else
                         begin
                           //Переотправляем запрос
                           if FTParameters.Downloading or FTUseOpenUrl then
                             Result := SendRequest
                           else
                             Result := SendRequestEx;
                           if Result then
                             Result := GetStatusCode(StatusCode);
                         end;
                     end;
    ERROR_CANCELLED: begin{1223} //Когда юзер жмет отмену, при диалоге получения сертификата
                       //**** Формируем сообщение с текстом последней ошибки
                       LastError := GetLastError;
                       GetMessage(MSG_SEND_REQUEST_ERROR, [],
                                  [mMessage, mError], True);
                       //****
                     end;
    ERROR_INTERNET_FORCE_RETRY:{12032} //Когда требуется переотправка запроса
                     begin
                       //Переотправляем запрос
                       if FTParameters.Downloading or FTUseOpenUrl then
                         Result := SendRequest
                       else
                         Result := SendRequestEx;
                       if Result then
                         Result := GetStatusCode(StatusCode);
                     end;
    ERROR_INVALID_HANDLE:{6} //Если указан неверный хендл окна (Handle = 0, когда не требуется отображать диалог)
                     begin
                       LastError := GetLastError;
                       if Auth then //Отправляем сообщение с текстом ответа сервера
                         begin
                           GetStatusCode(StatusCode);
                           GetMessage(MSG_QUERY_INFO_HTTP_ERROR, [GetQueryInfo(HTTP_QUERY_STATUS_TEXT), StatusCode],
                                      [mMessage, mError], False);
                         end
                       else //или текстом последней ошибки
                         GetMessage(MSG_SEND_REQUEST_ERROR, [],
                                    [mMessage, mError], True);
                       //****
                     end;
  end;
end;

function TDownloadThread.InetReadFile: boolean;
var
  ReadBuffer: PChar; //Буфер получаемых данных
  BufferLen: Cardinal;  //Размер полученных за раз данных
  StartPos: Cardinal;//Позиция для записи в файл
  NumOfRepeat: byte; //Количество повторов закачки
  tempStr: string;

  CurrTime: int64;
  CurrBytesReaded: Cardinal;
begin
  Result := False;
  CurrBytesReaded := 0;
  //Выделяем память под буфер данных
  ReadBuffer := StrAlloc(FTParameters.BufferSize);
  try
    SetLoadParameters;
    //Необходимо запустить InternetSetFilePointer, т.к. он позиция интернет-файла сбилась при определении размера,
    //но нельзя запускать, если не удалось определить Content-Length (MSDN не объясняет почему, но перестает работать InternetReadFile)
    if FTDataSize <> 0 then
      StartPos := InternetSetFilePointer(hRequest,                 //Хендл запроса
                                         FTParameters.LoadFrom,//Смещение, заданное юзером
                                         nil,
                                         FILE_BEGIN,               //Относительно начала файла
                                         0);
    //Если ввернулся ошибочный результат или InternetSetFilePointer - не запускался
    if (StartPos = DWORD(-1)) or (FTDataSize = 0) then
      begin
        StartPos := 0;//То установить позицию для записи на начало файла
        if FTParameters.LoadCount <> 0 then
          //И увеличить LoadCount на введенное юзером смещение (чтоб не получилось, что юзер запросил 200 байт, начиная с 100-го, а ему вернулось 200 байт с начала; теперь юзеру вернется 300 байт, в которые и будут входить запрошенные данные)
          Inc(FTParameters.LoadCount, FTParameters.LoadFrom);
      end;

    //Если размер данных определен и пользователь запросил количество данных, превышающее доступное
    if (FTDataSize <> 0) and (StartPos + FTParameters.LoadCount > FTDataSize) then
      if StartPos < FTDataSize then //Если начальная позиция скачивания меньше чем доступные данные
        //То уменьшаем количество доступных данных, до максимально возможного
        FTParameters.LoadCount := FTDataSize - StartPos
      else //Иначе, ставим 0 (что означает - качать все)
        FTParameters.LoadCount := 0;

    NumOfRepeat := 0;//Обнуляем количество повторов при ошибках
    FTCurrentTime := GetTime;

    //Если тип выходных данных - строка или поток
    if (FTParameters.TypeOfData = odString) or (FTParameters.TypeOfData = odStream) then
      begin
        while True do begin //Пока из цикла не выйдем командой Break
          BufferLen := 0;
          //Получаем порцию данных их инета и обрабатываем код ответа процедуры
          case GetInetData(ReadBuffer, FTParameters.BufferSize, BufferLen, NumOfRepeat) of
            0: ;                    //Продолжаем выполнение цикла ничего не делая
            1: Continue;            //Стартуем новую итерацию цикла, пропуская идущие ниже команды
            2: begin                //Обнуляем все выходные значения и стартуем новую итерацию цикла
                 FTBytesReaded := 0;
                 FTRecivedString := '';
                 if Assigned(FTRecivedStream) then
                   FTRecivedStream.SetSize(0);
                 Continue;
               end;
            3: begin                //Выходим из цикла с результатом - успех
                 Result := True;
                 Break;
               end;
            4: begin                //Выходим из цикла с результатом - неудача
                 Result := False;
                 Break;
               end;
          end;
          tempStr := ReadBuffer; //Записываем полученные данные в строку
          SetLength(tempStr, BufferLen); //Устанавливаем требуемый размер строки
          if FTParameters.TypeOfData = odStream then
            begin
              FTRecivedStream.Write(PChar(tempStr)^, Length(tempStr));
            end
          else
            begin
              FTRecivedString := FTRecivedString + tempStr; //Добавляем строку к уже полученным данным
            end;
          FTBytesReaded := (FTBytesReaded + BufferLen); //Считаем количество полученных данных
          //**** Выводим количество полученных данных
          GetMessage(IntToStr(FTBytesReaded), [],
                     [mProgress, mBytesReaded], False);

          //Получаем текущее время
          CurrTime := GetTime;
          //Если размер буфера больше минимально расчетного
          if BufferLen >= MIN_SIZE_TO_CALCULATE then
            begin
              //То считаем скорость
              GetMessage(IntToStr(GetSpeed(BufferLen, FTCurrentTime, CurrTime)), [],
                         [mProgress, mSpeed], False);
              FTCurrentTime := CurrTime;
            end
          else //если меньше
            begin
              //то складываем полученные данные
              CurrBytesReaded := (CurrBytesReaded + BufferLen);
              //пока они не будут больше минимально расчетного
              if CurrBytesReaded >= MIN_SIZE_TO_CALCULATE then
                begin
                  //потом считаем скорость
                  GetMessage(IntToStr(GetSpeed(CurrBytesReaded, FTCurrentTime, CurrTime)), [],
                             [mProgress, mSpeed], False);
                  CurrBytesReaded := 0;
                  FTCurrentTime := CurrTime;
                end;
            end;
          //****
        end;
      end
    //Если тип выходных данных - файл
    else if FTParameters.TypeOfData = odFile then
      begin
        //В зависимости от выбранного типа записи
        case FTParameters.WriteMethod of
          wmSaveBytePos: begin //С сохранением позиции как в интернет-файле:
                          //Создаем файл *полного* размера, с проверкой существования
                          if not SetFileSize(FTParameters.FileName, FTDataSize, True) then
                            Exit;
                        end;
          wmRewrite:    begin //Перезапись:
                          //Создаем файл *требуемого* размера, без проверки существования
                          if FTParameters.LoadCount <> 0 then
                            begin
                              if not SetFileSize(FTParameters.FileName, FTParameters.LoadCount, False) then
                                Exit;
                            end
                          else
                            if not SetFileSize(FTParameters.FileName, FTDataSize, False) then
                              Exit;
                          //Устанавливаем позицию записи на начало файла
                          StartPos := 0;
                        end;
          wmAppend:     begin //Добавление:
                          //Устанавливаем позицию записи равной DWORD(-1) - тогда данные будут добавленны к существующему файлу
                          StartPos := DWORD(-1);
                        end;
        end;

        while True do begin //Пока из цикла не выйдем командой Break
          BufferLen := 0;
          //Получаем порцию данных их инета и обрабатываем код ответа процедуры
          case GetInetData(ReadBuffer, FTParameters.BufferSize, BufferLen, NumOfRepeat) of
            0: ;                    //Продолжаем выполнение цикла ничего не делая
            1: Continue;            //Стартуем новую итерацию цикла, пропуская идущие ниже команды
            2: begin
                 if FTParameters.WriteMethod = wmAppend then //Если мы добавляли данные к файлу
                   StartPos := StartPos - FTBytesReaded //То сместимся к началу добавления
                 else //В остальных случаях
                   StartPos := 0; //Сместимся в начало файла (для wmSaveBytePos - это нормально, т.к. в начале скачивания позиция тоже, скорее всего(?), не была определена)
                 FTBytesReaded := 0;//Обнуляем количество полученных данных
                 Continue;          //Стартуем новую итерацию цикла
               end;
            3: begin                //Выходим из цикла с результатом - успех
                 Result := True;
                 Break;
               end;
            4: begin                //Выходим из цикла с результатом - неудача
                 Result := False;
                 Break;
               end;
          end;
          //Записываем полученные данные в файл
          if not WriteFile(FTParameters.FileName, ReadBuffer, BufferLen, StartPos) then
            begin
              Result := False;
              Exit;
            end;
          //Считаем количество полученных данных
          FTBytesReaded := (FTBytesReaded + BufferLen);
          //**** Выводим количество полученных данных
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
    //Если остались непросчитанные данные
    if CurrBytesReaded > 0 then
      //Вычисляем скорость
      GetMessage(IntToStr(GetSpeed(CurrBytesReaded, FTCurrentTime, GetTime)), [],
                 [mProgress, mSpeed], False);
    //Освобождаем память
    StrDispose(ReadBuffer);
  end;
end;

//Запись данных на сервер
function TDownloadThread.InetWriteFile: boolean;
var
  Buffer: PChar;     //Буфер чтения
  BufSize: Cardinal; //Размер прочитанных данных в буфере
  tempStr: string;   //Временная строка для отправки данных
  BytesWriten: Cardinal;//Размер записанных на сервер данных, байт

  StartPos: Cardinal;
begin
  Result := False;
  if FTDataSize = 0 then
    Exit;

  StartPos := FTParameters.LoadFrom;

  //Выделяем память под буфер чтения
  Buffer := StrAlloc(FTParameters.BufferSize);
  try
    //Обнуляем начальные значения
    BytesWriten :=0;
    FTBytesReaded := 0;
    BufSize := 0;
    //Запускаем цикл записи файла
    while FTBytesReaded < FTNeedDataSize do
      begin
        with FTParameters do begin
          case TypeOfData of
            odFile:   begin //Заливаем файл
                        //Считываем данные из файла в буфер, определяем размер считанных данных
                        BufSize := ReadFile(FileName, Buffer, BufferSize, StartPos);
                      end;
            odString: begin //Заливаем строку
                        //Копируем часть передаваемой строки нужного размера
                        tempStr := Copy(UploadingString, StartPos, BufferSize);
                        //Устанавливаем размер скопированных данных
                        BufSize := Length(tempStr);
                        //Передаем строку в буфер
                        Buffer := PChar(tempStr);
                      end;
            odStream: begin //Заливаем поток
                        //Переводим поток на нужную позицию
                        FTUploadingStream.Seek(StartPos, soFromBeginning);
                        //Считываем данные из потока в буфер и определяем размер прочитанного
                        BufSize := FTUploadingStream.Read(Buffer^, BufferSize);
                      end;
          end;
        end;

        if BufSize > FTNeedDataSize then
          BufSize := FTNeedDataSize
        else if BufSize = 0 then
          Break;

        if not InternetWriteFile(hRequest, Buffer, BufSize, BytesWriten) then //Если произошла ошибка при записи файла на сервер
          begin
            LastError := GetLastError;
            //Выдаем сообщение
            GetMessage(MSG_INTERNET_WRITE_FILE_ERROR, [],
                   [mMessage, mError], True);
            Exit;//И завершаем цикл
          end;
        //Увеличиваем позицию чтения файла
        Inc(FTBytesReaded, BytesWriten);
        StartPos := FTBytesReaded;
        GetMessage(IntToStr(FTBytesReaded), [],
                   [mProgress, mBytesReaded], False);
      end;
    Result := True;
  finally
    Buffer := nil;     //Убираем ссылки
    StrDispose(Buffer);//Освобождаем память
  end;
end;

//Закрываем хендлы
procedure TDownloadThread.CloseHandles;
begin
  InternetCloseHandle(hRequest);
  InternetCloseHandle(hConnect);
  InternetCloseHandle(hSession);
end;

function TDownloadThread.HttpDownload: boolean;
var
  dwFlags: Cardinal; //Флаги для HttpOpenRequest

  StatusCode: Cardinal; //Содержит код ответа сервера
  tempStr: string; //Для записи результата в строку

  StartPos: Cardinal;//Позиция для записи в файл
begin
  //--Очищаем выходные значения--
  Result := False;

  //**** Формируем сообщение содержащее параметры запроса
  tempStr := '*URL*: ' + FTParameters.Url + '; *RequestMethod*: ' + FTParameters.RequestMethod;
  if ((FTParameters.RequestMethod <> 'GET') and (FTParameters.RequestMethod <> 'HEAD') and
    (FTParameters.PostType = ptQuery)) and (FTParameters.PostQuery <> '') then
    tempStr := tempStr + '; *' + FTParameters.RequestMethod + '-Query*: ' + FTParameters.PostQuery;
  GetMessage(MSG_PARAMETERS_INFO, [tempStr],
             [mMessage, mInfo], False);
  //****

  //Открываем сессию
  if InetOpen(0) then
    try
      //Создаем соединение
      if InetConnect(INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT) then //Флаги: поддерживать соединение (нужно, чтоб не вводить повторно логин/пароль), использовать существующее соединение
        begin
          //Заполняем флаги
          dwFlags := IIF(FTUrlStructure.NumScheme = INTERNET_SCHEME_HTTPS, //Если подключение - https
                         INTERNET_FLAG_SECURE or //То использовать след. флаги: Использовать защищенное соединение (SSL/PCT)
                         SECURITY_INTERNET_MASK, //Игнорировать некорректные сертификаты и редиректы
                         0);//Если соединение не https, то дополнительных флагов не нужно
          dwFlags := dwFlags or INTERNET_FLAG_RELOAD;//Добавить флаг: Не использовать кеш для загрузки файла

          //Создаем запрос
          if OpenRequest(dwFlags) then
            begin
              //Посылаем запрос
              if SendingRequest then
                //**** Выдаем сообщение об успешном получении информации от запроса
                GetMessage(MSG_QUERY_INFO_OK, [],
                           [mMessage, mOk], False)
                //****
              else
                Exit;

              GetStatusCode(StatusCode);

              //Если стоит галка AutoFileName и тип выходных данных - файл
              if FTParameters.AutoFileName and (FTParameters.TypeOfData = odFile) then
                //Формируем имя файла, как путь от введенного значения + имя файла, определенное из урл
                FTParameters.FileName := ExtractFilePath(FTParameters.FileName) + GetFileName;

              //Пытаемся получить размер запрашиваемых данных
              FTDataSize := GetDataSize;
              if FTDataSize <> 0 then //Если удалось определить размер
                begin
                  //**** Выводим сообщение о размере данных
                  GetMessage(MSG_QUERY_CONTENT_LENGTH_OK, [FormatFileSize(FTDataSize)],
                             [mMessage, mDataSize], False);
                  //****
                end
              else //Иначе
                begin
                  //**** Выводим сообщение об ошибке определения размера данных
                  GetMessage(MSG_QUERY_CONTENT_LENGTH_ERROR, [],
                             [mMessage, mDataSize], False);
                  //****
                end;
              //**** Передаем размер запрашиваемых данных
              GetMessage(IntToStr(FTDataSize), [],
                         [mProgress, mDataSize], False);
              //****

              //Размеру требуемых данных присваиваем размер файла
              FTNeedDataSize := FTDataSize;

              //Для HEAD-запроса и пользовательских запросов
              if not ((FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'POST')) then
                begin
                  FTCurrentTime := GetTime;
                  FTRecivedString := '';
                  //-- Собираем нужную инфу из заголовков --
                  tempStr := GetQueryInfo(HTTP_QUERY_RAW_HEADERS_CRLF or HTTP_QUERY_FLAG_REQUEST_HEADERS);
                  if tempStr <> '' then FTRecivedString := FTRecivedString + tempStr + LNBR + LNBR;
                  tempStr := GetQueryInfo(HTTP_QUERY_RAW_HEADERS_CRLF);
                  if tempStr <> '' then FTRecivedString := FTRecivedString + tempStr + LNBR;
                  //-----
                  //Размер прочитанных данных задаем как размер полученной инфы
                  FTBytesReaded := Length(FTRecivedString);

                  //Если нужен вывод в поток
                  if FTParameters.TypeOfData = odStream then
                    FTRecivedStream.Write(PChar(FTRecivedString)^, FTBytesReaded)

                  //Если нужен вывод в файл
                  else if (FTBytesReaded <> 0) and (FTParameters.TypeOfData = odFile) then
                    begin
                      //Меняем расширение файла, чтоб показать, что он содержит результат HEAD-запроса
                      if FTParameters.AutoFileName then
                        FTParameters.FileName := FTParameters.FileName + '_' + FTParameters.RequestMethod + '.txt';
                      //Если метод записи не "Добавление"
                      if FTParameters.WriteMethod <> wmAppend then
                        begin
                          StartPos := 0; //Установить позицию записи на начало файла
                          //Задать размер файла
                          SetFileSize(FTParameters.FileName, FTBytesReaded, False);
                        end
                      else//Для метода "Добавление"
                        //Установить позицию записи равной DWORD(-1) - тогда данные будут добавленны к существующему файлу
                        StartPos := DWORD(-1);
                      //Записать RecivedString в файл
                      WriteFile(FTParameters.FileName, PChar(FTRecivedString), FTBytesReaded, StartPos);
                    end;

                  //**** Выводим количество полученных данных
                  GetMessage(IntToStr(FTBytesReaded), [],
                             [mProgress, mBytesReaded], False);
                  GetMessage(MSG_PING, [GetTimeDiff(FTCurrentTime, GetTime)],
                             [mMessage, mInfo], False);
                  //****
                  Result := FTBytesReaded <> 0; //Вернуть успешный результат, если были прочитаны данные
                end
              else //Для других запросов
                begin
                  //Результат приравниваем к результату получения файла из инета
                  Result := InetReadFile;
                  if Result then //В случае успеха
                    begin
                      //**** Выводим сообщение
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
    finally //Закрывем хендлы
      CloseHandles;
    end;
end;

function TDownloadThread.HttpUpload: boolean;
var
  StatusCode: Cardinal;
  dwFlags: Cardinal; //Флаги для HttpOpenRequest
begin
  //--Очищаем выходные значения--
  Result := False;

  //Определяем размер передаваемых данных
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
      //***Выводим сообшение об ошибке ***
      GetMessage(MSG_OPEN_FILE_ERROR, [FTParameters.FileName],
                 [mMessage, mInfo], True);
      Exit;//И выходим
      //*********
    end;

  //Открываем сессию
  if InetOpen(0) then
    try
      //Создаем соединение
      if InetConnect(INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT) then //Флаги: поддерживать соединение (нужно, чтоб не вводить повторно логин/пароль), использовать существующее соединение
        begin
          //Заполняем флаги
          dwFlags := IIF(FTUrlStructure.NumScheme = INTERNET_SCHEME_HTTPS, //Если подключение - https
                         INTERNET_FLAG_SECURE or //То использовать след. флаги: Использовать защищенное соединение (SSL/PCT)
                         SECURITY_INTERNET_MASK, //Игнорировать некорректные сертификаты и редиректы
                         0);//Если соединение не https, то дополнительных флагов не нужно
          dwFlags := dwFlags or INTERNET_FLAG_RELOAD{ or INTERNET_FLAG_NO_CACHE_WRITE};//Добавить флаги: Не использовать кеш для загрузки и заливки файла

          //Заливка файла осуществляется методом 'PUT'
          FTParameters.RequestMethod := 'PUT';

          //Создаем запрос
          if OpenRequest(dwFlags) then
            begin
              GetMessage(MSG_FILE_SIZE, [FormatFileSize(FTDataSize)],
                         [mMessage, mDataSize], False);
              GetMessage(IntToStr(FTDataSize), [],
                         [mProgress, mDataSize], False);

              FTCurrentTime := GetTime;
              if SendingRequest then
                begin
                  //Расчитываем скорость
                  GetMessage(IntToStr(GetSpeed(FTBytesReaded, FTCurrentTime, GetTime)), [],
                             [mProgress, mSpeed], False);

                  //**** Выдаем сообщение об успешном получении информации от запроса
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
    finally //Закрывем хендлы
      CloseHandles;
    end;
end;

function TDownloadThread.FtpDownload: boolean;
var
  tempStr: string; //Для записи результата в строку
  dwFlags: Cardinal;//Флаги

  StartPos: Cardinal;//Позиция для записи в файл

  FtpFile: TWin32FindData;//Сведения о файле на сервере
begin
  //--Очищаем выходные значения--
  Result := False;

  //**** Формируем сообщение содержащее параметры запроса
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

  //Открываем сессию
  if InetOpen(0) then
    try
      //Флаги: поддерживать соединение (нужно, чтоб не вводить повторно логин/пароль), использовать существующее соединение
      dwFlags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT;
      //Добавить флаг: Использовать пассивный режим FTP
      if FTParameters.FtpPassive then
        dwFlags := dwFlags or INTERNET_FLAG_PASSIVE;

      //Создаем соединение
      if InetConnect(dwFlags) then
        begin
          FTCurrentTime := GetTime;
          //Находим файл
          if not FtpFindFile(0, FtpFile) then
            Exit //Если файл не найден - выходим
          else
            begin
              //Определяем размер файла
              FTDataSize := FtpFile.nFileSizeLow;

              //**** Передаем размер запрашиваемых данных
              GetMessage(IntToStr(FTDataSize), [],
                         [mProgress, mDataSize], False);
              //****

              //Если стоит галка AutoFileName и тип выходных данных - файл
              if FTParameters.AutoFileName and (FTParameters.TypeOfData = odFile) then
                //Формируем имя файла, как путь от введенного значения + имя файла, определенное из урл
                FTParameters.FileName := ExtractFilePath(FTParameters.FileName) + GetFileName;

              FtpSetCurrentDir(FtpFile);

              //Размеру требуемых данных присваиваем размер файла
              FTNeedDataSize := FTDataSize;

              if not ((FTParameters.RequestMethod = 'GET') or (FTParameters.RequestMethod = 'POST')) then
                begin
                  FTCurrentTime := GetTime;

                  //Для HEAD-запроса
                  if FTParameters.RequestMethod = 'HEAD' then
                    begin
                      //-- Собираем нужную инфу --
                      FTRecivedString := Format(MSG_FTP_FILE_INFO, [FtpFile.cFileName,
                        FileAttrToStr(FtpFile.dwFileAttributes), FormatFileSize(FtpFile.nFileSizeLow),
                        FileTimeToStr(FtpFile.ftCreationTime), FileTimeToStr(FtpFile.ftLastWriteTime),
                        FileTimeToStr(FtpFile.ftLastAccessTime)]);

                      FTBytesReaded := Length(FTRecivedString);

                      //Если нужен вывод в поток
                      if FTParameters.TypeOfData = odStream then
                        FTRecivedStream.Write(PChar(FTRecivedString)^, FTBytesReaded)

                      //Если нужен вывод в файл
                      else if (FTBytesReaded <> 0) and (FTParameters.TypeOfData = odFile) then
                        begin
                          //Меняем расширение файла, чтоб показать, что он содержит результат HEAD-запроса
                          if FTParameters.AutoFileName then
                            FTParameters.FileName := FTParameters.FileName + '_' + FTParameters.RequestMethod + '.txt';
                          //Если метод записи не "Добавление"
                          if FTParameters.WriteMethod <> wmAppend then
                            begin
                              StartPos := 0; //Установить позицию записи на начало файла
                              //Задать размер файла
                              SetFileSize(FTParameters.FileName, FTBytesReaded, False);
                            end
                          else//Для метода "Добавление"
                            //Установить позицию записи равной DWORD(-1) - тогда данные будут добавленны к существующему файлу
                            StartPos := DWORD(-1);
                          //Записать RecivedString в файл
                          WriteFile(FTParameters.FileName, PChar(FTRecivedString), FTBytesReaded, StartPos);
                        end;

                      Result := FTBytesReaded <> 0; //Вернуть успешный результат, если были прочитаны данные
                    end
                  else
                    Result := FtpSendingCommand;

                  //**** Выводим количество полученных данных
                  GetMessage(IntToStr(FTBytesReaded), [],
                             [mProgress, mBytesReaded], False);
                  GetMessage(MSG_PING, [GetTimeDiff(FTCurrentTime, GetTime)],
                             [mMessage, mInfo], False);
                  //****
                end
              else //Для других запросов
                begin
                  //Заполняем флаги
                  dwFlags := FTP_TRANSFER_TYPE_BINARY or INTERNET_FLAG_RELOAD;//Добавить флаг: Не использовать кеш для загрузки файла

                  //if FTParameters.LoadFrom <> 0 then
                    //if not FtpSendCommand('REST '+IntToStr(FTParameters.LoadFrom), tempStr) then
                      //begin
                        //if FTParameters.LoadCount <> 0 then
                          //Inc(FTParameters.LoadCount, FTParameters.LoadFrom);
                        //FTParameters.LoadFrom := 0;
                      //end;

                  if FtpOpen(dwFlags, GENERIC_READ) then
                    begin
                      //Результат приравниваем к результату получения файла из инета
                      Result := InetReadFile;
                      if Result then //В случае успеха
                        begin
                          //**** Выводим сообщение
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
    finally //Закрывем хендлы
      CloseHandles;
    end;
end;

function TDownloadThread.FtpUpload: boolean;
var
  dwFlags: Cardinal; //Флаги для FtpOpen
  tempStr: string;
begin
  //--Очищаем выходные значения--
  Result := False;

  //Определяем размер передаваемых данных
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
      //***Выводим сообшение об ошибке ***
      GetMessage(MSG_OPEN_FILE_ERROR, [FTParameters.FileName],
                 [mMessage, mInfo], True);
      Exit;//И выходим
      //*********
    end;

  //Открываем сессию
  if InetOpen(0) then
    try
      //Флаги: поддерживать соединение (нужно, чтоб не вводить повторно логин/пароль), использовать существующее соединение
      dwFlags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_EXISTING_CONNECT;
      //Добавить флаг: Использовать пассивный режим FTP
      if FTParameters.FtpPassive then
        dwFlags := dwFlags or INTERNET_FLAG_PASSIVE;
      //Создаем соединение
      if InetConnect(dwFlags) then //Флаги: поддерживать соединение (нужно, чтоб не вводить повторно логин/пароль), использовать существующее соединение
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
              dwFlags := FTP_TRANSFER_TYPE_BINARY or INTERNET_FLAG_RELOAD;//Добавить флаг: Не использовать кеш для загрузки файла
              if FtpOpen(dwFlags, GENERIC_WRITE) then
                Result := InetWriteFile;
            end;

          if Result then
            //Считаем скорость
            GetMessage(IntToStr(GetSpeed(FTBytesReaded, FTCurrentTime, GetTime)), [],
                       [mProgress, mSpeed], False);

          FTparameters.Url := GetQueryOptions(INTERNET_OPTION_URL);
        end;
    finally //Закрывем хендлы
      CloseHandles;
    end;
end;

//Общая функция скачивания для HTTP, FTP и GOPHER
function TDownloadThread.InetDownload: boolean;
var
  StatusCode: Cardinal; //Содержит код ответа сервера
  tempStr: string; //Для записи результата в строку
begin
  //--Очищаем выходные значения--
  Result := False;
  FTDataSize := 0;

  //**** Формируем сообщение содержащее параметры запроса
  tempStr := '*URL*: ' + FTParameters.Url;
  GetMessage(MSG_PARAMETERS_INFO, [tempStr],
             [mMessage, mInfo], False);
  //****

  //Открываем сессию
  if InetOpen(0) then
    try
      //Создаем соединение и посылаем запрос
      if SendingRequest then
        //**** Выдаем сообщение об успешном получении информации от запроса
        GetMessage(MSG_QUERY_INFO_OK, [],
                   [mMessage, mOk], False)
        //****
      else
        Exit;

      GetStatusCode(StatusCode);

      //Если стоит галка AutoFileName и тип выходных данных - файл
      if FTParameters.AutoFileName and (FTParameters.TypeOfData = odFile) then
        //Формируем имя файла, как путь от введенного значения + имя файла, определенное из урл
        FTParameters.FileName := ExtractFilePath(FTParameters.FileName) + GetFileName;

      //Пытаемся получить размер запрашиваемых данных
      if FTDataSize = 0 then
        FTDataSize := GetDataSize;

      if FTDataSize <> 0 then //Если удалось определить размер
        begin
          //**** Выводим сообщение о размере данных
          GetMessage(MSG_QUERY_CONTENT_LENGTH_OK, [FormatFileSize(FTDataSize)],
                     [mMessage, mDataSize], False);
          //****
        end
      else //Иначе
        begin
          //**** Выводим сообщение об ошибке определения размера данных
          GetMessage(MSG_QUERY_CONTENT_LENGTH_ERROR, [],
                     [mMessage, mDataSize], False);
          //****
        end;
      //**** Передаем размер запрашиваемых данных
      GetMessage(IntToStr(FTDataSize), [],
                 [mProgress, mDataSize], False);
      //****

      //Размеру требуемых данных присваиваем размер файла
      FTNeedDataSize := FTDataSize;

      //Результат приравниваем к результату получения файла из инета
      Result := InetReadFile;
      if Result then //В случае успеха
        begin
          //**** Выводим сообщение
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
    finally //Закрывем хендлы
      CloseHandles;
    end;
end;

end.
