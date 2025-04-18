{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Giurizzato Junior                         }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatu� - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrNFSeXNotasFiscais;

interface

uses
  Classes, SysUtils,
  {$IF DEFINED(HAS_SYSTEM_GENERICS)}
   System.Generics.Collections, System.Generics.Defaults,
  {$ELSEIF DEFINED(DELPHICOMPILER16_UP)}
   System.Contnrs,
  {$Else}
   Contnrs,
  {$IfEnd}
  IniFiles,
  ACBrBase, ACBrDFe, ACBrNFSeXConfiguracoes, ACBrNFSeXClass, ACBrNFSeXConversao;

type

  { TNotaFiscal }

  TNotaFiscal = class(TCollectionItem)
  private
    FNFSe: TNFSe;
    FACBrNFSe: TACBrDFe;

    FAlertas: string;
    FNomeArq: string;
    FNomeArqRps: string;
    FConfirmada: Boolean;
    FXmlRps: string;
    FXmlNfse: string;
    FXmlEspelho: string;

    function CalcularNomeArquivo: string;
    function CalcularPathArquivo: string;
    procedure SetXmlNfse(const Value: string);
    function GetXmlNfse: string;

  public
    constructor Create(AOwner: TACBrDFe);
    destructor Destroy; override;

    procedure Imprimir;
    procedure ImprimirPDF; overload;
    procedure ImprimirPDF(AStream: TStream); overload;

    function LerXML(const AXML: string): Boolean;
    function LerArqIni(const AIniString: string): Boolean;
    function GerarNFSeIni: string;

    function GerarXML: string;
    function GravarXML(const NomeArquivo: string = '';
      const PathArquivo: string = ''; aTipo: TtpXML = txmlNFSe): Boolean;

    function GravarStream(AStream: TStream): Boolean;

    procedure EnviarEmail(const sPara, sAssunto: string; sMensagem: TStrings = nil;
      EnviaPDF: Boolean = True; sCC: TStrings = nil; Anexos: TStrings = nil;
      sReplyTo: TStrings = nil; ManterPDFSalvo: Boolean = True);

    property NomeArq: string    read FNomeArq    write FNomeArq;
    property NomeArqRps: string read FNomeArqRps write FNomeArqRps;

    function CalcularNomeArquivoCompleto(NomeArquivo: string = '';
      PathArquivo: string = ''): string;

    property NFSe: TNFSe read FNFSe;

    property XmlRps: string read FXmlRps write FXmlRps;
    property XmlNfse: string read GetXmlNfse write SetXmlNfse;
    property XmlEspelho: string read FXmlEspelho write FXmlEspelho;

    property Confirmada: Boolean read FConfirmada write FConfirmada;
    property Alertas: string     read FAlertas;

  end;

  { TNotasFiscais }

  TNotasFiscais = class(TACBrObjectList)
  private
    FTransacao: Boolean;
    FNumeroLote: string;
    FACBrNFSe: TACBrDFe;
    FConfiguracoes: TConfiguracoesNFSe;
    FXMLLoteOriginal: string;
    FXMLLoteAssinado: string;
    FAlertas: string;

    function GetItem(Index: integer): TNotaFiscal;
    procedure SetItem(Index: integer; const Value: TNotaFiscal);

    procedure VerificarDANFSE;
  public
    constructor Create(AOwner: TACBrDFe);

    procedure GerarNFSe;
    procedure Imprimir;
    procedure ImprimirPDF; overload;
    procedure ImprimirPDF(AStream: TStream); overload;

    function New: TNotaFiscal; reintroduce;
    function Add(ANota: TNotaFiscal): Integer; reintroduce;
    Procedure Insert(Index: Integer; ANota: TNotaFiscal); reintroduce;
    function FindByRps(const ANumRPS: string): TNotaFiscal;
    function FindByNFSe(const ANumNFSe: string): TNotaFiscal;
    function FindByCnpjCpfSerieRps(const CnpjCpf, Serie, ANumRPS: string): TNotaFiscal;

    property Items[Index: integer]: TNotaFiscal read GetItem write SetItem; default;

    function GetNamePath: string;

    // Incluido o Parametro AGerarNFSe que determina se ap�s carregar os dados da NFSe
    // para o componente, ser� gerado ou n�o novamente o XML da NFSe.
    function LoadFromFile(const CaminhoArquivo: string; AGerarNFSe: Boolean = True): Boolean;
    function LoadFromStream(AStream: TStringStream; AGerarNFSe: Boolean = True): Boolean;
    function LoadFromString(const AXMLString: string; AGerarNFSe: Boolean = True): Boolean;
    function LoadFromIni(const AIniString: string): Boolean;
    function LoadFromLoteNfse(const CaminhoArquivo: string): Boolean;

    function GerarIni: string;
    function GravarXML(const PathNomeArquivo: string = ''): Boolean;

    property XMLLoteOriginal: string read FXMLLoteOriginal write FXMLLoteOriginal;
    property XMLLoteAssinado: string read FXMLLoteAssinado write FXMLLoteAssinado;
    property NumeroLote: string      read FNumeroLote      write FNumeroLote;
    property Transacao: Boolean      read FTransacao       write FTransacao;
    property Alertas: string         read FAlertas;

    property ACBrNFSe: TACBrDFe read FACBrNFSe;
  end;

  function CompRpsPorNumero(const Item1,
    Item2: {$IfDef HAS_SYSTEM_GENERICS}TObject{$Else}Pointer{$EndIf}): Integer;
  function CompNFSePorNumero(const Item1,
    Item2: {$IfDef HAS_SYSTEM_GENERICS}TObject{$Else}Pointer{$EndIf}): Integer;
  function CompRpsPorCnpjCpfSerieNumero(const Item1,
    Item2: {$IfDef HAS_SYSTEM_GENERICS}TObject{$Else}Pointer{$EndIf}): Integer;

implementation

uses
  synautil, StrUtilsEx,
  ACBrUtil.DateTime,
  ACBrUtil.Base, ACBrUtil.Strings, ACBrUtil.FilesIO, ACBrUtil.XMLHTML,
  ACBrDFeUtil,
  ACBrNFSeX, ACBrNFSeXInterface;

function CompRpsPorNumero(const Item1,
  Item2: {$IfDef HAS_SYSTEM_GENERICS}TObject{$Else}Pointer{$EndIf}): Integer;
var
  NumRps1, NumRps2: Integer;
begin
  NumRps1 := StrToIntDef(TNotaFiscal(Item1).NFSe.IdentificacaoRps.Numero, 0);
  NumRps2 := StrToIntDef(TNotaFiscal(Item2).NFSe.IdentificacaoRps.Numero, 0);

  if NumRps1 < NumRps2 then
    Result := -1
  else if NumRps1 > NumRps2 then
    Result := 1
  else
    Result := 0;
end;

function CompNFSePorNumero(const Item1,
  Item2: {$IfDef HAS_SYSTEM_GENERICS}TObject{$Else}Pointer{$EndIf}): Integer;
var
  NumNFSe1, NumNFSe2: Int64;
begin
  NumNFSe1 := StrToInt64Def(TNotaFiscal(Item1).NFSe.Numero, 0);
  NumNFSe2 := StrToInt64Def(TNotaFiscal(Item2).NFSe.Numero, 0);

  if NumNFSe1 < NumNFSe2 then
    Result := -1
  else if NumNFSe1 > NumNFSe2 then
    Result := 1
  else
    Result := 0;
end;

function CompRpsPorCnpjCpfSerieNumero(const Item1,
  Item2: {$IfDef HAS_SYSTEM_GENERICS}TObject{$Else}Pointer{$EndIf}): Integer;
var
  NumRps1, NumRps2: string;
begin
  NumRps1 :=
    PadLeft(TNotaFiscal(Item1).NFSe.Prestador.IdentificacaoPrestador.CpfCnpj, 14, '0') +
    PadLeft(TNotaFiscal(Item1).NFSe.IdentificacaoRps.Serie, 5, '0') +
    PadLeft(TNotaFiscal(Item1).NFSe.IdentificacaoRps.Numero, 15, '0');
  NumRps2 :=
    PadLeft(TNotaFiscal(Item2).NFSe.Prestador.IdentificacaoPrestador.CpfCnpj, 14, '0') +
    PadLeft(TNotaFiscal(Item2).NFSe.IdentificacaoRps.Serie, 5, '0') +
    PadLeft(TNotaFiscal(Item2).NFSe.IdentificacaoRps.Numero, 15, '0');

  if NumRps1 < NumRps2 then
    Result := -1
  else if NumRps1 > NumRps2 then
    Result := 1
  else
    Result := 0;
end;

{ TNotaFiscal }

constructor TNotaFiscal.Create(AOwner: TACBrDFe);
begin
  if not (AOwner is TACBrNFSeX) then
    raise EACBrNFSeException.Create('AOwner deve ser do tipo TACBrNFSeX');

  FACBrNFSe := TACBrNFSeX(AOwner);
  FNFSe := TNFSe.Create;
end;

destructor TNotaFiscal.Destroy;
begin
  FNFSe.Free;

  inherited Destroy;
end;

procedure TNotaFiscal.Imprimir;
begin
  with TACBrNFSeX(FACBrNFSe) do
  begin
    DANFSE.Provedor := Configuracoes.Geral.Provedor;

    if Configuracoes.WebServices.AmbienteCodigo = 1 then
      DANFSE.Producao := snSim
    else
      DANFSE.Producao := snNao;

    if not Assigned(DANFSE) then
      raise EACBrNFSeException.Create('Componente DANFSE n�o associado.')
    else
      DANFSE.ImprimirDANFSE(NFSe);
  end;
end;

procedure TNotaFiscal.ImprimirPDF;
begin
  with TACBrNFSeX(FACBrNFSe) do
  begin
    DANFSE.Provedor := Configuracoes.Geral.Provedor;

    if Configuracoes.WebServices.AmbienteCodigo = 1 then
      DANFSE.Producao := snSim
    else
      DANFSE.Producao := snNao;

    if not Assigned(DANFSE) then
      raise EACBrNFSeException.Create('Componente DANFSE n�o associado.')
    else
      DANFSE.ImprimirDANFSEPDF(NFSe);
  end;
end;

procedure TNotaFiscal.ImprimirPDF(AStream: TStream);
begin
  with TACBrNFSeX(FACBrNFSe) do
  begin
    DANFSE.Provedor := Configuracoes.Geral.Provedor;

    if not Assigned(DANFSE) then
      raise EACBrNFSeException.Create('Componente DANFSE n�o associado.')
    else
    begin
      AStream.Size := 0;
      DANFSE.ImprimirDANFSEPDF(AStream, NFSe);
    end;
  end;
end;

function TNotaFiscal.LerArqIni(const AIniString: string): Boolean;
var
  INIRec: TMemIniFile;
  FProvider: IACBrNFSeXProvider;
  sSecao, sFim, sData: string;
  Ok: Boolean;
  i: Integer;
  Item: TItemServicoCollectionItem;
  ItemDocDeducao: TDocDeducaoCollectionItem;
  ItemParcelas: TParcelasCollectionItem;
begin
  INIRec := TMemIniFile.Create('');

  try
    LerIniArquivoOuString(AIniString, INIRec);

    FProvider := TACBrNFSeX(FACBrNFSe).Provider;

    if not Assigned(FProvider) then
      raise EACBrNFSeException.Create(ERR_SEM_PROVEDOR);

    with FNFSe do
    begin
      // Provedor Infisc - Layout Proprio
      sSecao := 'IdentificacaoNFSe';
      if INIRec.SectionExists(sSecao) then
      begin
        Numero := INIRec.ReadString(sSecao, 'Numero', '');
        cNFSe := GerarCodigoDFe(StrToIntDef(Numero, 0));
        NumeroLote := INIRec.ReadString(sSecao, 'NumeroLote', '');
        ModeloNFSe := INIRec.ReadString(sSecao, 'ModeloNFSe', '');
        refNF := INIRec.ReadString(sSecao, 'refNF', '');
        TipoEmissao := StrToTipoEmissao(Ok, INIRec.ReadString(sSecao, 'TipoEmissao', 'N'));
        Canhoto := StrToCanhoto(Ok, INIRec.ReadString(sSecao, 'Canhoto', '0'));
        EmpreitadaGlobal := StrToEmpreitadaGlobal(Ok, INIRec.ReadString(sSecao, 'EmpreitadaGlobal', '2'));
        CodigoVerificacao := INIRec.ReadString(sSecao, 'CodigoVerificacao', '');
        SituacaoNFSe := StrToStatusNFSe(Ok, INIRec.ReadString(sSecao, 'StatusNFSe', ''));
        InfID.ID := INIRec.ReadString(sSecao, 'ID', '');
        NfseSubstituida := INIRec.ReadString(sSecao, 'NfseSubstituida', '');
        NfseSubstituidora := INIRec.ReadString(sSecao, 'NfseSubstituidora', '');
        ValorCredito := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorCredito', ''), 0);
        ChaveAcesso := INIRec.ReadString(sSecao, 'ChaveAcesso', '');
        Link := INIRec.ReadString(sSecao, 'Link', '');
        DescricaoCodigoTributacaoMunicipio := INIRec.ReadString(sSecao, 'DescricaoCodigoTributacaoMunicipio', '');
        Assinatura := INIRec.ReadString(sSecao, 'Assinatura', '');
      end;

      sSecao := 'IdentificacaoRps';
      if INIRec.SectionExists(sSecao) then
      begin
        SituacaoTrib := FProvider.StrToSituacaoTrib(Ok, INIRec.ReadString(sSecao, 'SituacaoTrib', 'tp'));

        //Provedores CTA, ISSBarueri, ISSSDSF, ISSSaoPaulo, Simple e SmarAPD.
        if INIRec.ReadString(sSecao, 'TipoTributacaoRPS', 'FIM') <> 'FIM' then
          TipoTributacaoRPS := FProvider.StrToTipoTributacaoRPS(Ok, INIRec.ReadString(sSecao, 'TipoTributacaoRPS', ''));

        // Provedor AssessorPublico
        Situacao := INIRec.ReadInteger(sSecao, 'Situacao', 0);

        Producao := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'Producao', '1'));
        StatusRps := FProvider.StrToStatusRPS(Ok, INIRec.ReadString(sSecao, 'Status', '1'));
        OutrasInformacoes := INIRec.ReadString(sSecao, 'OutrasInformacoes', '');
        OutrasInformacoes := StringReplace(OutrasInformacoes, FProvider.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]);

        // Provedores: Infisc, ISSDSF e Siat
        SeriePrestacao := INIRec.ReadString(sSecao, 'SeriePrestacao', '');

        IdentificacaoRemessa := INIRec.ReadString(sSecao, 'IdentificacaoRemessa', '');
        IdentificacaoRps.Numero := INIRec.ReadString(sSecao, 'Numero', '0');
        IdentificacaoRps.Serie := INIRec.ReadString(sSecao, 'Serie', '0');
        IdentificacaoRps.Tipo := FProvider.StrToTipoRPS(Ok, INIRec.ReadString(sSecao, 'Tipo', '1'));

        sData := INIRec.ReadString(sSecao, 'DataEmissao', '');
        if sData <> '' then
          DataEmissao := StringToDateTimeDef(sData, 0);

        sData := INIRec.ReadString(sSecao, 'Competencia', '');
        if sData <> '' then
          Competencia := StringToDateTimeDef(sData, 0);

        sData := INIRec.ReadString(sSecao, 'DataEmissaoRps', '');
        if sData <> '' then
          DataEmissaoRps := StringToDateTimeDef(sData, 0)
        else
          DataEmissaoRPS := DataEmissao;

        sData := INIRec.ReadString(sSecao, 'Vencimento', '');
        if sData <> '' then
          Vencimento := StringToDateTimeDef(sData, 0);

        sData := INIRec.ReadString(sSecao, 'DataPagamento', '');
        if sData <> '' then
          DataPagamento := StringToDateTimeDef(sData, 0);

        sData := INIRec.ReadString(sSecao, 'dhRecebimento', '');
        if sData <> '' then
          dhRecebimento := StringToDateTimeDef(sData, 0);

        NaturezaOperacao := StrToNaturezaOperacao(Ok, INIRec.ReadString(sSecao, 'NaturezaOperacao', '0'));

        // Provedor Tecnos
        PercentualCargaTributaria := StringToFloatDef(INIRec.ReadString(sSecao, 'PercentualCargaTributaria', ''), 0);
        ValorCargaTributaria := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCargaTributaria', ''), 0);
        PercentualCargaTributariaMunicipal := StringToFloatDef(INIRec.ReadString(sSecao, 'PercentualCargaTributariaMunicipal', ''), 0);
        ValorCargaTributariaMunicipal := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCargaTributariaMunicipal', ''), 0);
        PercentualCargaTributariaEstadual := StringToFloatDef(INIRec.ReadString(sSecao, 'PercentualCargaTributariaEstadual', ''), 0);
        ValorCargaTributariaEstadual := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCargaTributariaEstadual', ''), 0);

        // Provedor PadraoNacional
        verAplic := INIRec.ReadString(sSecao, 'verAplic', 'ACBrNFSeX-1.00');
        tpEmit := StrTotpEmit(Ok, INIRec.ReadString(sSecao, 'tpEmit', '1'));

        // Provedor Governa
        RegRec := StrToRegRec(Ok, INIRec.ReadString(sSecao, 'RegRec', ''));
        // Provedor Governa e Prescon
        FrmRec := StrToFrmRec(Ok, INIRec.ReadString(sSecao, 'FrmRec', ''));

        InformacoesComplementares := INIRec.ReadString(sSecao, 'InformacoesComplementares', '');

        EqptoRecibo := INIRec.ReadString(sSecao, 'EqptoRecibo', '');
        TipoRecolhimento := INIRec.ReadString(sSecao, 'TipoRecolhimento', '');
        TipoNota := INIRec.ReadInteger(sSecao, 'TipoNota', 0);
        // Provedor Tecnos
        SiglaUF := INIRec.ReadString(sSecao, 'SiglaUF', '');
        EspecieDocumento := INIRec.ReadInteger(sSecao, 'EspecieDocumento', 0);
        SerieTalonario := INIRec.ReadInteger(sSecao, 'SerieTalonario', 0);
        FormaPagamento := INIRec.ReadInteger(sSecao, 'FormaPagamento', 0);
        NumeroParcelas := INIRec.ReadInteger(sSecao, 'NumeroParcelas', 0);
        id_sis_legado := INIRec.ReadInteger(sSecao, 'id_sis_legado', 0);
        DeducaoMateriais := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'DeducaoMateriais', ''));
      end;

      sSecao := 'RpsSubstituido';
      if INIRec.SectionExists(sSecao) then
      begin
        RpsSubstituido.Numero := INIRec.ReadString(sSecao, 'Numero', '');
        RpsSubstituido.Serie := INIRec.ReadString(sSecao, 'Serie', '');
        RpsSubstituido.Tipo := FProvider.StrToTipoRPS(Ok, INIRec.ReadString(sSecao, 'Tipo', '1'));
      end;

      sSecao := 'NFSeSubstituicao';
      if INIRec.SectionExists(sSecao) then
      begin
        subst.chSubstda := INIRec.ReadString(sSecao, 'chSubstda', '');
        subst.cMotivo := StrTocMotivo(Ok, INIRec.ReadString(sSecao, 'cMotivo', ''));
        subst.xMotivo := INIRec.ReadString(sSecao, 'xMotivo', '');
      end;

      sSecao := 'NFSeCancelamento';
      if INIRec.SectionExists(sSecao) then
      begin
        MotivoCancelamento := INIRec.ReadString(sSecao, 'MotivoCancelamento', '');
        JustificativaCancelamento := INIRec.ReadString(sSecao, 'JustificativaCancelamento', '');
        CodigoCancelamento := INIRec.ReadString(sSecao, 'CodigoCancelamento', '');
        NFSeCancelamento.Pedido.IdentificacaoNfse.Numero := INIRec.ReadString(sSecao, 'NumeroNFSe', '');
        NfseCancelamento.Pedido.IdentificacaoNfse.Cnpj := INIRec.ReadString(sSecao, 'CNPJ', '');
        NFSeCancelamento.Pedido.IdentificacaoNfse.InscricaoMunicipal := INIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
        NFSeCancelamento.Pedido.IdentificacaoNfse.CodigoMunicipio := INIRec.ReadString(sSecao, 'CodigoMunicipio', '');
        NfseCancelamento.Pedido.CodigoCancelamento := INIRec.ReadString(sSecao, 'CodCancel', '');
        NFSeCancelamento.Sucesso := INIRec.ReadBool(sSecao, 'Sucesso', True);
        NfSeCancelamento.DataHora := INIRec.ReadDateTime(sSecao, 'DataHora', 0);
      end;

      sSecao := 'Prestador';
      if INIRec.SectionExists(sSecao) then
      begin
        RegimeEspecialTributacao := FProvider.StrToRegimeEspecialTributacao(Ok, INIRec.ReadString(sSecao, 'Regime', '0'));
        OptanteSimplesNacional := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'OptanteSN', '1'));
        OptanteSN := StrToOptanteSN(Ok, INIRec.ReadString(sSecao, 'opSimpNac', '2'));
        OptanteMEISimei := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'OptanteMEISimei', ''));
        DataOptanteSimplesNacional := INIRec.ReadDateTime(sSecao, 'DataOptanteSimplesNacional', 0);

        IncentivadorCultural := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'IncentivadorCultural', '1'));

        if INIRec.ReadString(sSecao, 'RegimeApuracaoSN', '') <> '' then
          RegimeApuracaoSN := StrToRegimeApuracaoSN(Ok, INIRec.ReadString(sSecao, 'RegimeApuracaoSN', '1'));

        Prestador.IdentificacaoPrestador.CpfCnpj := INIRec.ReadString(sSecao, 'CNPJ', '');
        Prestador.IdentificacaoPrestador.InscricaoMunicipal := INIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
        Prestador.IdentificacaoPrestador.InscricaoEstadual := INIRec.ReadString(sSecao, 'InscricaoEstadual', '');

        Prestador.IdentificacaoPrestador.Nif := INIRec.ReadString(sSecao, 'NIF', '');
        Prestador.IdentificacaoPrestador.cNaoNIF := StrToNaoNIF(Ok, INIRec.ReadString(sSecao, 'cNaoNIF', '0'));
        Prestador.IdentificacaoPrestador.CAEPF := INIRec.ReadString(sSecao, 'CAEPF', '');
        Prestador.IdentificacaoPrestador.Tipo := FProvider.StrToTipoPessoa(Ok, INIRec.ReadString(sSecao, 'TipoPessoa', ''));

        // Para o provedor ISSDigital deve-se informar tamb�m:
        Prestador.cUF := UFparaCodigoUF(INIRec.ReadString(sSecao, 'UF', 'SP'));

        Prestador.crc := INIRec.ReadString(sSecao, 'crc', '');
        Prestador.crc_estado := INIRec.ReadString(sSecao, 'crc_estado', '');

        Prestador.RazaoSocial := INIRec.ReadString(sSecao, 'RazaoSocial', '');
        Prestador.NomeFantasia := INIRec.ReadString(sSecao, 'NomeFantasia', '');

        Prestador.Endereco.TipoLogradouro := INIRec.ReadString(sSecao, 'TipoLogradouro', '');
        Prestador.Endereco.Endereco := INIRec.ReadString(sSecao, 'Logradouro', '');
        Prestador.Endereco.Numero := INIRec.ReadString(sSecao, 'Numero', '');
        Prestador.Endereco.Complemento := INIRec.ReadString(sSecao, 'Complemento', '');
        Prestador.Endereco.Bairro := UTF8ToNativeString(INIRec.ReadString(sSecao, 'Bairro', ''));
        Prestador.Endereco.CodigoMunicipio := INIRec.ReadString(sSecao, 'CodigoMunicipio', '');
        Prestador.Endereco.xMunicipio := INIRec.ReadString(sSecao, 'xMunicipio', '');
        Prestador.Endereco.UF := INIRec.ReadString(sSecao, 'UF', '');
        Prestador.Endereco.CodigoPais := INIRec.ReadInteger(sSecao, 'CodigoPais', 0);
        Prestador.Endereco.xPais := INIRec.ReadString(sSecao, 'xPais', '');
        Prestador.Endereco.CEP := INIRec.ReadString(sSecao, 'CEP', '');

        Prestador.Contato.DDD := INIRec.ReadString(sSecao, 'DDD', '');
        Prestador.Contato.Telefone := INIRec.ReadString(sSecao, 'Telefone', '');
        Prestador.Contato.Email := INIRec.ReadString(sSecao, 'Email', '');
        Prestador.Contato.xSite := INIRec.ReadString(sSecao, 'xSite', '');

        // Para o provedor WebFisco
        Prestador.Anexo := INIRec.ReadString(sSecao, 'Anexo', '');
        Prestador.ValorReceitaBruta := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorReceitaBruta', ''), 0);
        Prestador.DataInicioAtividade := StringToDateTimeDef(INIRec.ReadString(sSecao, 'DataInicioAtividade', ''), 0);
      end;

      sSecao := 'Tomador';
      if INIRec.SectionExists(sSecao) then
      begin
        Tomador.IdentificacaoTomador.Tipo := FProvider.StrToTipoPessoa(Ok, INIRec.ReadString(sSecao, 'Tipo', '1'));
        Tomador.IdentificacaoTomador.CpfCnpj := INIRec.ReadString(sSecao, 'CNPJCPF', '');
        Tomador.IdentificacaoTomador.InscricaoMunicipal := INIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
        Tomador.IdentificacaoTomador.InscricaoEstadual := INIRec.ReadString(sSecao, 'InscricaoEstadual', '');

        Tomador.IdentificacaoTomador.Nif := INIRec.ReadString(sSecao, 'NIF', '');
        Tomador.IdentificacaoTomador.cNaoNIF := StrToNaoNIF(Ok, INIRec.ReadString(sSecao, 'cNaoNIF', '0'));
        Tomador.IdentificacaoTomador.CAEPF := INIRec.ReadString(sSecao, 'CAEPF', '');
        Tomador.IdentificacaoTomador.DocEstrangeiro := INIRec.ReadString(sSecao, 'DocEstrangeiro', '');

        Tomador.RazaoSocial := INIRec.ReadString(sSecao, 'RazaoSocial', '');
        Tomador.NomeFantasia := INIRec.ReadString(sSecao, 'NomeFantasia', '');

        Tomador.Endereco.EnderecoInformado := FProvider.StrToSimNaoOpc(Ok, INIRec.ReadString(sSecao, 'EnderecoInformado', ''));
        Tomador.Endereco.TipoLogradouro := INIRec.ReadString(sSecao, 'TipoLogradouro', '');
        Tomador.Endereco.Endereco := INIRec.ReadString(sSecao, 'Logradouro', '');
        Tomador.Endereco.Numero := INIRec.ReadString(sSecao, 'Numero', '');
        Tomador.Endereco.Complemento := INIRec.ReadString(sSecao, 'Complemento', '');
        Tomador.Endereco.PontoReferencia := INIRec.ReadString(sSecao, 'PontoReferencia', '');
        Tomador.Endereco.Bairro := INIRec.ReadString(sSecao, 'Bairro', '');
        Tomador.Endereco.TipoBairro := INIRec.ReadString(sSecao, 'TipoBairro', '');
        Tomador.Endereco.CodigoMunicipio := INIRec.ReadString(sSecao, 'CodigoMunicipio', '');
        Tomador.Endereco.xMunicipio := INIRec.ReadString(sSecao, 'xMunicipio', '');
        Tomador.Endereco.UF := INIRec.ReadString(sSecao, 'UF', '');
        Tomador.Endereco.CodigoPais := INIRec.ReadInteger(sSecao, 'CodigoPais', 0);
        Tomador.Endereco.CEP := INIRec.ReadString(sSecao, 'CEP', '');
        // Provedor Equiplano � obrigat�rio o pais e IE
        Tomador.Endereco.xPais := INIRec.ReadString(sSecao, 'xPais', '');

        Tomador.Contato.DDD := INIRec.ReadString(sSecao, 'DDD', '');
        Tomador.Contato.TipoTelefone := INIRec.ReadString(sSecao, 'TipoTelefone', '');
        Tomador.Contato.Telefone := INIRec.ReadString(sSecao, 'Telefone', '');
        Tomador.Contato.Email := INIRec.ReadString(sSecao, 'Email', '');

        Tomador.AtualizaTomador := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'AtualizaTomador', '1'));
        Tomador.TomadorExterior := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'TomadorExterior', '2'));
      end;

      sSecao := 'Intermediario';
      if INIRec.SectionExists(sSecao)then
      begin
        Intermediario.Identificacao.CpfCnpj := INIRec.ReadString(sSecao, 'CNPJCPF', '');
        Intermediario.Identificacao.InscricaoMunicipal := INIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
        Intermediario.Identificacao.Nif := INIRec.ReadString(sSecao, 'NIF', '');
        Intermediario.Identificacao.cNaoNIF := StrToNaoNIF(Ok, INIRec.ReadString(sSecao, 'cNaoNIF', '0'));
        Intermediario.Identificacao.CAEPF := INIRec.ReadString(sSecao, 'CAEPF', '');

        Intermediario.IssRetido := FProvider.StrToSituacaoTributaria(Ok, INIRec.ReadString(sSecao, 'IssRetido', ''));
        Intermediario.RazaoSocial := INIRec.ReadString(sSecao, 'RazaoSocial', '');

        Intermediario.Endereco.CodigoMunicipio := INIRec.ReadString(sSecao, 'CodigoMunicipio', '');
        Intermediario.Endereco.CEP := INIRec.ReadString(sSecao, 'CEP', '');
        Intermediario.Endereco.CodigoPais := INIRec.ReadInteger(sSecao, 'CodigoPais', 0);
        Intermediario.Endereco.xMunicipio := INIRec.ReadString(sSecao, 'xMunicipio', '');
        Intermediario.Endereco.UF := INIRec.ReadString(sSecao, 'UF', '');
        Intermediario.Endereco.Endereco := INIRec.ReadString(sSecao, 'Logradouro', '');
        Intermediario.Endereco.Numero := INIRec.ReadString(sSecao, 'Numero', '');
        Intermediario.Endereco.Complemento := INIRec.ReadString(sSecao, 'Complemento', '');
        Intermediario.Endereco.Bairro := INIRec.ReadString(sSecao, 'Bairro', '');

        Intermediario.Contato.Telefone := INIRec.ReadString(sSecao, 'Telefone', '');
        Intermediario.Contato.Email := INIRec.ReadString(sSecao, 'Email', '');
      end;


      //SmarAPD, Infisc.
      sSecao := 'Transportadora';
      if INIRec.SectionExists(sSecao) then
      begin
        Transportadora.xNomeTrans := INIRec.ReadString(sSecao, 'xNomeTrans', '');
        Transportadora.xCpfCnpjTrans := INIRec.ReadString(sSecao, 'xCpfCnpjTrans', '');
        Transportadora.xInscEstTrans := INIRec.ReadString(sSecao, 'xInscEstTrans', '');
        Transportadora.xPlacaTrans := INIRec.ReadString(sSecao, 'xPlacaTrans', '');
        Transportadora.xEndTrans := INIRec.ReadString(sSecao, 'xEndTrans', '');
        Transportadora.cMunTrans := INIRec.ReadInteger(sSecao, 'cMunTrans', 0);
        Transportadora.xMunTrans := INIRec.ReadString(sSecao, 'xMunTrans', '');
        Transportadora.xUFTrans := INIRec.ReadString(sSecao, 'xUFTrans', '');
        Transportadora.xPaisTrans := INIRec.ReadString(sSecao, 'xPaisTrans', '');
        Transportadora.vTipoFreteTrans := StrToTipoFrete(Ok, INIRec.ReadString(sSecao, 'vTipoFreteTrans', ''));
      end;

      sSecao := 'ConstrucaoCivil';
      if INIRec.SectionExists(sSecao) then
      begin
        ConstrucaoCivil.CodigoObra := INIRec.ReadString(sSecao, 'CodigoObra', '');
        ConstrucaoCivil.Art := INIRec.ReadString(sSecao, 'Art', '');
        ConstrucaoCivil.inscImobFisc := INIRec.ReadString(sSecao, 'inscImobFisc', '');
        ConstrucaoCivil.nCei := INIRec.ReadString(sSecao, 'nCei', '');
        ConstrucaoCivil.nProj := INIRec.ReadString(sSecao, 'nProj', '');
        ConstrucaoCivil.nMatri := INIRec.ReadString(sSecao, 'nMatri', '');
        ConstrucaoCivil.nNumeroEncapsulamento := INIRec.ReadString(sSecao, 'nNumeroEncapsulamento', '');

        ConstrucaoCivil.Endereco.CEP := INIRec.ReadString(sSecao, 'CEP', '');
        ConstrucaoCivil.Endereco.xMunicipio := INIRec.ReadString(sSecao, 'xMunicipio', '');
        ConstrucaoCivil.Endereco.UF := INIRec.ReadString(sSecao, 'UF', '');
        ConstrucaoCivil.Endereco.Endereco := INIRec.ReadString(sSecao, 'Logradouro', '');
        ConstrucaoCivil.Endereco.Numero := INIRec.ReadString(sSecao, 'Numero', '');
        ConstrucaoCivil.Endereco.Complemento := INIRec.ReadString(sSecao, 'Complemento', '');
        ConstrucaoCivil.Endereco.Bairro := INIRec.ReadString(sSecao, 'Bairro', '');
      end;

      sSecao := 'Servico';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.ItemListaServico := INIRec.ReadString(sSecao, 'ItemListaServico', '');
        Servico.xItemListaServico := INIRec.ReadString(sSecao, 'xItemListaServico', '');
        Servico.CodigoCnae := INIRec.ReadString(sSecao, 'CodigoCnae', '');
        Servico.CodigoTributacaoMunicipio := INIRec.ReadString(sSecao, 'CodigoTributacaoMunicipio', '');
        Servico.xCodigoTributacaoMunicipio := INIRec.ReadString(sSecao, 'xCodigoTributacaoMunicipio', '');
        Servico.Discriminacao := INIRec.ReadString(sSecao, 'Discriminacao', '');
        Servico.Discriminacao := StringReplace(Servico.Discriminacao, FProvider.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]);
        Servico.Descricao := INIRec.ReadString(sSecao, 'Descricao', '');
        Servico.Descricao := StringReplace(Servico.Descricao, FProvider.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]);
        Servico.CodigoMunicipio := INIRec.ReadString(sSecao, 'CodigoMunicipio', '');
        Servico.CodigoPais := INIRec.ReadInteger(sSecao, 'CodigoPais', 0);
        Servico.ExigibilidadeISS := FProvider.StrToExigibilidadeISS(Ok, INIRec.ReadString(sSecao, 'ExigibilidadeISS', '1'));
        Servico.IdentifNaoExigibilidade := INIRec.ReadString(sSecao, 'IdentifNaoExigibilidade', '');
        Servico.MunicipioIncidencia := INIRec.ReadInteger(sSecao, 'MunicipioIncidencia', 0);
        Servico.xMunicipioIncidencia := INIRec.ReadString(sSecao, 'xMunicipioIncidencia', '');
        Servico.NumeroProcesso := INIRec.ReadString(sSecao, 'NumeroProcesso', '');
        Servico.MunicipioPrestacaoServico := INIRec.ReadString(sSecao, 'MunicipioPrestacaoServico', '');
        if Trim(Servico.MunicipioPrestacaoServico) <> '' then
          FProvider.ConfigGeral.ImprimirLocalPrestServ := True
        else
          FProvider.ConfigGeral.ImprimirLocalPrestServ := False;
        Servico.UFPrestacao := INIRec.ReadString(sSecao, 'UFPrestacao', '');
        Servico.ResponsavelRetencao := FProvider.StrToResponsavelRetencao(Ok, INIRec.ReadString(sSecao, 'ResponsavelRetencao', ''));
        Servico.TipoLancamento := StrToTipoLancamento(Ok, INIRec.ReadString(sSecao, 'TipoLancamento', 'P'));

        // Provedor ISSDSF
        Servico.Operacao := StrToOperacao(Ok, INIRec.ReadString(sSecao, 'Operacao', ''));
        Servico.Tributacao := FProvider.StrToTributacao(Ok, INIRec.ReadString(sSecao, 'Tributacao', ''));
        // Provedor ISSSaoPaulo
        Servico.ValorTotalRecebido := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorTotalRecebido', ''), 0);
        Servico.ValorCargaTributaria := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorCargaTributaria', ''), 0);
        Servico.PercentualCargaTributaria := StrToFloatDef(INIRec.ReadString(sSecao, 'PercentualCargaTributaria', ''), 0);
        Servico.FonteCargaTributaria := INIRec.ReadString(sSecao, 'FonteCargaTributaria', '');

        // Provedor IssNet e Padr�o Nacional
        Servico.CodigoNBS := INIRec.ReadString(sSecao, 'CodigoNBS', '');
        Servico.CodigoInterContr := INIRec.ReadString(sSecao, 'CodigoInterContr', '');

        // Provedor SoftPlan
        Servico.CFPS := INIRec.ReadString(sSecao, 'CFPS', '');

        // Provedor Giap Informa��es sobre o Endere�o da Presta��o de Servi�o
        Servico.Endereco.Bairro := INIRec.ReadString(sSecao, 'Bairro', '');
        Servico.Endereco.CEP := INIRec.ReadString(sSecao, 'CEP', '');
        Servico.Endereco.xMunicipio := INIRec.ReadString(sSecao, 'xMunicipio', '');
        Servico.Endereco.Complemento := INIRec.ReadString(sSecao, 'Complemento', '');
        Servico.Endereco.Endereco := INIRec.ReadString(sSecao, 'Logradouro', '');
        Servico.Endereco.Numero := INIRec.ReadString(sSecao, 'Numero', '');
        Servico.Endereco.xPais := INIRec.ReadString(sSecao, 'xPais', '');
        Servico.Endereco.UF := INIRec.ReadString(sSecao, 'UF', '');

        // Provedor ISSBarueri
        Servico.LocalPrestacao := StrToLocalPrestacao(Ok, INIRec.ReadString(sSecao, 'LocalPrestacao', '1'));
        Servico.PrestadoEmViasPublicas := INIRec.ReadBool(sSecao, 'PrestadoEmViasPublicas', True);

        // Provedor Megasoft
        Servico.InfAdicional := INIRec.ReadString(sSecao, 'InfAdicional', '');

        // Provedor SigISSWeb
        Servico.xFormaPagamento := INIRec.ReadString(sSecao, 'xFormaPagamento', '');
      end;

      i := 1;
      while true do
      begin
        sSecao := 'Deducoes' + IntToStrZero(I + 1, 3);
        sFim := INIRec.ReadString(sSecao, 'ValorDeduzir', 'FIM');
        if (Length(sFim) <= 0) or (sFim = 'FIM') then
          break;

        with Servico.Deducao.New do
        begin
          DeducaoPor := FProvider.StrToDeducaoPor(Ok, INIRec.ReadString(sSecao, 'DeducaoPor', ''));
          TipoDeducao := FProvider.StrToTipoDeducao(Ok, INIRec.ReadString(sSecao, 'TipoDeducao', ''));
          CpfCnpjReferencia := INIRec.ReadString(sSecao, 'CpfCnpjReferencia', '');
          NumeroNFReferencia := INIRec.ReadString(sSecao, 'NumeroNFReferencia', '');
          ValorTotalReferencia := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorTotalReferencia', ''), 0);
          PercentualDeduzir := StrToFloatDef(INIRec.ReadString(sSecao, 'PercentualDeduzir', ''), 0);
          ValorDeduzir := StrToFloatDef(sFim, 0);
        end;

        Inc(i);
      end;

      i := 1;
      while true do
      begin
        sSecao := 'Impostos' + IntToStrZero(I + 1, 3);
        sFim := INIRec.ReadString(sSecao, 'Valor', 'FIM');

        if (Length(sFim) <= 0) or (sFim = 'FIM') then
          break;

        with Servico.Imposto.New do
        begin
          Codigo := INIRec.ReadInteger(sSecao, 'Codigo', 0);
          Descricao := INIRec.ReadString(sSecao, 'Descricao', '');
          Aliquota := StrToFloatDef(INIRec.ReadString(sSecao, 'Aliquota', ''), 0);
          Valor := StrToFloatDef(sFim, 0);
        end;
        Inc(i);
      end;

      //Infisc
      i := 1;
      while true do
      begin
        sSecao := 'Despesas' + IntToStrZero(I + 1, 3);
        sFim := INIRec.ReadString(sSecao, 'vDesp', 'FIM');

        if (Length(sFim) <= 0) or (sFim='FIM') then
          break;

        with Despesa.New do
        begin
          nItemDesp := INIRec.ReadString(sSecao, 'nItemDesp', '');
          xDesp := INIRec.ReadString(sSecao, 'xDesp', '');
          dDesp := INIRec.ReadDateTime(sSecao, 'dDesp', 0);
          vDesp := StrToFloatDef(sFim, 0);
        end;

        Inc(i);
      end;

      //Conam
      i := 1;
      while true do
      begin
        sSecao := 'Email' + IntToStrZero(I + 1, 1);
        sFim := INIRec.ReadString(sSecao, 'emailCC', 'FIM');

        if (Length(sFim) <= 0) or (sFim = 'FIM') then
          break;

        with email.New do
          emailCC := sFim;

        Inc(i);
      end;

      i := 1;
      while true do
      begin
        sSecao := 'Genericos' + IntToStrZero(I + 1, 1);
        if not INIRec.SectionExists(sSecao) then
          break;

        with Genericos.New do
        begin
          Titulo := INIRec.ReadString(sSecao, 'Titulo', '');
          Descricao := INIRec.ReadString(sSecao, 'Descricao', '');
        end;

        Inc(i);
      end;

      i := 1;
      while true do
      begin
        sSecao := 'Quartos' + IntToStrZero(i, 3);
        sFim := INIRec.ReadString(sSecao, 'CodigoInternoQuarto', 'FIM');

        if(Length(sFim) <= 0) or (sFim = 'FIM')then
          break;

        with Quartos.New do
        begin
          CodigoInternoQuarto := StrToIntDef(sFim, 0);
          QtdHospedes := INIRec.ReadInteger(sSecao, 'QtdHospedes', 0);
          CheckIn := INIRec.ReadDateTime(sSecao, 'CheckIn', 0);
          QtdDiarias := INIRec.ReadInteger(sSecao, 'QtdDiarias', 0);
          ValorDiaria := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorDiaria', ''), 0);
        end;

        Inc(i);
      end;

      i := 1;
      while true do
      begin
        sSecao := 'Itens' + IntToStrZero(i, 3);
        sFim := INIRec.ReadString(sSecao, 'Descricao'  ,'FIM');

        if (sFim = 'FIM') then
          break;

        Item := Servico.ItemServico.New;

        Item.Descricao := StringReplace(sFim, FProvider.ConfigGeral.QuebradeLinha, sLineBreak, [rfReplaceAll]);
        Item.ItemListaServico := INIRec.ReadString(sSecao, 'ItemListaServico', '');
        Item.xItemListaServico := INIRec.ReadString(sSecao, 'xItemListaServico', '');
        Item.CodServ := INIRec.ReadString(sSecao, 'CodServico', '');
        Item.codLCServ := INIRec.ReadString(sSecao, 'codLCServico', '');
        Item.CodigoCnae := INIRec.ReadString(sSecao, 'CodigoCnae', '');

        Item.TipoUnidade := StrToUnidade(Ok, INIRec.ReadString(sSecao, 'TipoUnidade', '2'));
        Item.Unidade := INIRec.ReadString(sSecao, 'Unidade', '');
        Item.Quantidade := StringToFloatDef(INIRec.ReadString(sSecao, 'Quantidade', ''), 0);
        Item.ValorUnitario := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorUnitario', ''), 0);

        Item.QtdeDiaria := StringToFloatDef(INIRec.ReadString(sSecao, 'QtdeDiaria', ''), 0);
        Item.ValorTaxaTurismo := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorTaxaTurismo', ''), 0);

        Item.ValorDeducoes := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorDeducoes', ''), 0);
        Item.xJustDeducao := INIRec.ReadString(sSecao, 'xJustDeducao', '');

        Item.AliqReducao := StringToFloatDef(INIRec.ReadString(sSecao, 'AliqReducao', ''), 0);
        Item.ValorReducao := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorReducao', ''), 0);

        Item.ValorISS := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorISS', ''), 0);
        Item.Aliquota := StringToFloatDef(INIRec.ReadString(sSecao, 'Aliquota', ''), 0);
        Item.BaseCalculo := StringToFloatDef(INIRec.ReadString(sSecao, 'BaseCalculo', ''), 0);
        Item.DescontoIncondicionado := StringToFloatDef(INIRec.ReadString(sSecao, 'DescontoIncondicionado', ''), 0);
        Item.DescontoCondicionado := StringToFloatDef(INIRec.ReadString(sSecao, 'DescontoCondicionado', ''), 0);

        Item.AliqISSST := StringToFloatDef(INIRec.ReadString(sSecao, 'AliqISSST', ''), 0);
        Item.ValorISSST := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorISSST', ''), 0);

        Item.ValorBCCSLL := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorBCCSLL', ''), 0);
        Item.AliqRetCSLL := StringToFloatDef(INIRec.ReadString(sSecao, 'AliqRetCSLL', ''), 0);
        Item.ValorCSLL := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCSLL', ''), 0);

        Item.ValorBCPIS := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorBCPIS', ''), 0);
        Item.AliqRetPIS := StringToFloatDef(INIRec.ReadString(sSecao, 'AliqRetPIS', ''), 0);
        Item.ValorPIS := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorPIS', ''), 0);

        Item.ValorBCCOFINS := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorBCCOFINS', ''), 0);
        Item.AliqRetCOFINS := StringToFloatDef(INIRec.ReadString(sSecao, 'AliqRetCOFINS', ''), 0);
        Item.ValorCOFINS := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCOFINS', ''), 0);

        Item.ValorBCINSS := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorBCINSS', ''), 0);
        Item.AliqRetINSS := StringToFloatDef(INIRec.ReadString(sSecao, 'AliqRetINSS', ''), 0);
        Item.ValorINSS := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorINSS', ''), 0);

        Item.ValorBCRetIRRF := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorBCRetIRRF', ''), 0);
        Item.AliqRetIRRF := StringToFloatDef(INIRec.ReadString(sSecao, 'AliqRetIRRF', ''), 0);
        Item.ValorIRRF := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorIRRF', ''), 0);

        Item.ValorTotal := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorTotal', ''), 0);

        Item.Tributavel := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'Tributavel', '1'));

        // IPM
        Item.TribMunPrestador := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'TribMunPrestador', '1'));
        Item.CodMunPrestacao := INIRec.ReadString(sSecao, 'CodMunPrestacao', '');
        Item.SituacaoTributaria := INIRec.ReadInteger(sSecao, 'SituacaoTributaria', 0);
        Item.ValorISSRetido := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorISSRetido', ''), 0);
        Item.ValorTributavel := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorTributavel', ''), 0);
        Item.CodCNO := INIRec.ReadString(sSecao, 'CodCNO', '');

        Item.idCnae := INIRec.ReadString(sSecao, 'idCnae', '');

        // Provedor Infisc
        Item.totalAproxTribServ := StringToFloatDef(INIRec.ReadString(sSecao, 'totalAproxTribServ', ''), 0);

        sSecao := 'DadosDeducao' + IntToStrZero(I + 1, 3);
        if INIRec.SectionExists(sSecao) then
        begin
          Item.DadosDeducao.TipoDeducao := FProvider.StrToTipoDeducao(Ok, INIRec.ReadString(sSecao, 'TipoDeducao', ''));
          Item.DadosDeducao.CpfCnpj := INIRec.ReadString(sSecao, 'CpfCnpj', '');
          Item.DadosDeducao.NumeroNotaFiscalReferencia := INIRec.ReadString(sSecao, 'NumeroNotaFiscalReferencia', '');
          Item.DadosDeducao.ValorTotalNotaFiscal := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorTotalNotaFiscal', ''), 0);
          Item.DadosDeducao.PercentualADeduzir := StrToFloatDef(INIRec.ReadString(sSecao, 'PercentualADeduzir', ''), 0);
          Item.DadosDeducao.ValorADeduzir := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorADeduzir', ''), 0);
        end;

        //Agili
        sSecao := 'DadosProssionalParceiro' + IntToStrZero(I + 1, 3);
        if INIRec.SectionExists(sSecao) then
        begin
          Item.DadosProfissionalParceiro.IdentificacaoParceiro.CpfCnpj := INIRec.ReadString(sSecao, 'CpfCnpj', '');
          Item.DadosProfissionalParceiro.IdentificacaoParceiro.InscricaoMunicipal := INIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
          Item.DadosProfissionalParceiro.RazaoSocial := INIRec.ReadString(sSecao, 'RazaoSocial', '');
          Item.DadosProfissionalParceiro.PercentualProfissionalParceiro := StrToFloatDef(INIRec.ReadString(sSecao, 'PercentualProfissionalParceiro', ''), 0);
        end;

        Inc(i);
      end;

      //Padr�o Nacional
      sSecao := 'ComercioExterior';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.comExt.mdPrestacao := StrTomdPrestacao(Ok, INIRec.ReadString(sSecao, 'mdPrestacao', '0'));
        Servico.comExt.vincPrest := StrTovincPrest(Ok, INIRec.ReadString(sSecao, 'vincPrest', '0'));
        Servico.comExt.tpMoeda := INIRec.ReadInteger(sSecao, 'tpMoeda', 0);
        Servico.comExt.vServMoeda := StringToFloatDef(INIRec.ReadString(sSecao, 'vServMoeda', '0'), 0);
        Servico.comExt.mecAFComexP := StrTomecAFComexP(Ok, INIRec.ReadString(sSecao, 'mecAFComexP', '00'));
        Servico.comExt.mecAFComexT := StrTomecAFComexT(Ok, INIRec.ReadString(sSecao, 'mecAFComexT', '00'));
        Servico.comExt.movTempBens := StrToMovTempBens(Ok, INIRec.ReadString(sSecao, 'movTempBens', '00'));
        Servico.comExt.nDI := INIRec.ReadString(sSecao, 'nDI', '');
        Servico.comExt.nRE := INIRec.ReadString(sSecao, 'nRE', '');
        Servico.comExt.mdic := INIRec.ReadInteger(sSecao, 'mdic', 0);
      end;

      //Padr�o Nacional
      sSecao := 'LocacaoSubLocacao';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.Locacao.categ := StrTocateg(Ok, INIRec.ReadString(sSecao, 'categ', '1'));
        Servico.Locacao.objeto := StrToobjeto(Ok, INIRec.ReadString(sSecao, 'objeto', '1'));
        Servico.Locacao.extensao := INIRec.ReadString(sSecao, 'extensao', '');
        Servico.Locacao.nPostes := INIRec.ReadInteger(sSecao, 'nPostes', 0);
      end;

      //Padr�o Nacional
      sSecao := 'Evento';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.Evento.xNome := INIRec.ReadString(sSecao, 'xNome', '');
        Servico.Evento.dtIni := INIRec.ReadDate(sSecao, 'dtIni', Now);
        Servico.Evento.dtFim := INIRec.ReadDate(sSecao, 'dtFim', Now);
        Servico.Evento.idAtvEvt := INIRec.ReadString(sSecao, 'idAtvEvt', '');

        Servico.Evento.Endereco.CEP := INIRec.ReadString(sSecao, 'CEP', '');
        Servico.Evento.Endereco.xMunicipio := INIRec.ReadString(sSecao, 'xMunicipio', '');
        Servico.Evento.Endereco.UF := INIRec.ReadString(sSecao, 'UF', '');
        Servico.Evento.Endereco.Endereco := INIRec.ReadString(sSecao, 'Logradouro', '');
        Servico.Evento.Endereco.Numero := INIRec.ReadString(sSecao, 'Numero', '');
        Servico.Evento.Endereco.Complemento := INIRec.ReadString(sSecao, 'Complemento', '');
        Servico.Evento.Endereco.Bairro := INIRec.ReadString(sSecao, 'Bairro', '');
      end;

      //Padr�o Nacional
      sSecao := 'Rodoviaria';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.explRod.categVeic := StrTocategVeic(Ok, INIRec.ReadString(sSecao, 'categVeic', '00'));
        Servico.explRod.nEixos := INIRec.ReadInteger(sSecao, 'nEixos', 0);
        Servico.explRod.rodagem := StrTorodagem(Ok, INIRec.ReadString(sSecao, 'rodagem', '1'));
        Servico.explRod.sentido := INIRec.ReadString(sSecao, 'sentido', '');
        Servico.explRod.placa := INIRec.ReadString(sSecao, 'placa', '');
        Servico.explRod.codAcessoPed := INIRec.ReadString(sSecao, 'codAcessoPed', '');
        Servico.explRod.codContrato := INIRec.ReadString(sSecao, 'codContrato', '');
      end;

      //Padr�o Nacional
      sSecao := 'InformacoesComplementares';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.infoCompl.idDocTec := INIRec.ReadString(sSecao, 'idDocTec', '');
        Servico.infoCompl.docRef := INIRec.ReadString(sSecao, 'docRef', '');
        Servico.infoCompl.xInfComp := INIRec.ReadString(sSecao, 'xInfComp', '');
      end;

      sSecao := 'Valores';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.Valores.ValorServicos := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorServicos', ''), 0);
        Servico.Valores.ValorDeducoes := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorDeducoes', ''), 0);
        Servico.Valores.AliquotaDeducoes := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaDeducoes', ''), 0);
        Servico.Valores.JustificativaDeducao := INIRec.ReadString(sSecao, 'JustificativaDeducao', '');

        Servico.Valores.ValorPis := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorPis', ''), 0);
        Servico.Valores.AliquotaPis := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaPis', ''), 0);
        Servico.Valores.RetidoPis := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'RetidoPis', ''));

        Servico.Valores.ValorCofins := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCofins', ''), 0);
        Servico.Valores.AliquotaCofins := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaCofins', ''), 0);
        Servico.Valores.RetidoCofins := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'RetidoCofins', ''));

        Servico.Valores.ValorInss := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorInss', ''), 0);
        Servico.Valores.AliquotaInss := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaInss', ''), 0);
        Servico.Valores.RetidoInss := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'RetidoInss', ''));

        Servico.Valores.ValorIr := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorIr', ''), 0);
        Servico.Valores.AliquotaIr := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaIr', ''), 0);
        Servico.Valores.RetidoIr := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'RetidoIr', ''));

        Servico.Valores.ValorCsll := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCsll', ''), 0);
        Servico.Valores.AliquotaCsll := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaCsll', ''), 0);
        Servico.Valores.RetidoCsll := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'RetidoCsll', ''));

        Servico.Valores.AliquotaCpp := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaCpp', ''), 0);
        Servico.Valores.ValorCpp := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorCpp', ''), 0);
        Servico.Valores.RetidoCpp := FProvider.StrToSimNao(Ok, INIRec.ReadString(sSecao, 'RetidoCpp', ''));
        Servico.Valores.ISSRetido := FProvider.StrToSituacaoTributaria(Ok, INIRec.ReadString(sSecao, 'ISSRetido', '0'));

        Servico.Valores.valorOutrasRetencoes := StringToFloatDef(INIRec.ReadString(sSecao, 'valorOutrasRetencoes', ''), 0);
        Servico.Valores.OutrasRetencoes := StringToFloatDef(INIRec.ReadString(sSecao, 'OutrasRetencoes', ''), 0);
        Servico.Valores.DescricaoOutrasRetencoes := INIRec.ReadString(sSecao, 'DescricaoOutrasRetencoes', '');
        Servico.Valores.DescontoIncondicionado := StringToFloatDef(INIRec.ReadString(sSecao, 'DescontoIncondicionado', ''), 0);
        Servico.Valores.DescontoCondicionado := StringToFloatDef(INIRec.ReadString(sSecao, 'DescontoCondicionado', ''), 0);
        Servico.Valores.OutrosDescontos := StringToFloatDef(INIRec.ReadString(sSecao, 'OutrosDescontos', ''), 0);

        Servico.Valores.ValorRepasse := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorRepasse', ''), 0);

        Servico.Valores.BaseCalculo := StringToFloatDef(INIRec.ReadString(sSecao, 'BaseCalculo', ''), 0);
        Servico.Valores.Aliquota := StringToFloatDef(INIRec.ReadString(sSecao, 'Aliquota', ''), 0);
        Servico.Valores.AliquotaSN := StringToFloatDef(INIRec.ReadString(sSecao, 'AliquotaSN', ''), 0);
        Servico.Valores.ValorIss := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorIss', ''), 0);
        Servico.Valores.ValorIssRetido := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorIssRetido', ''), 0);

        Servico.Valores.ValorLiquidoNfse := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorLiquidoNfse', ''), 0);

        Servico.Valores.ValorTotalNotaFiscal := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorTotalNotaFiscal', ''), 0);
        if Servico.Valores.ValorTotalNotaFiscal = 0 then
          Servico.Valores.ValorTotalNotaFiscal := Servico.Valores.ValorServicos - Servico.Valores.DescontoCondicionado - Servico.Valores.DescontoIncondicionado;

        Servico.Valores.ValorTotalTributos := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorTotalTributos', ''), 0);

        Servico.Valores.IrrfIndenizacao := StringtoFloatDef(INIRec.ReadString(sSecao, 'IrrfIndenizacao', ''), 0);
        Servico.Valores.RetencoesFederais := StringToFloatDef(INIRec.ReadString(sSecao, 'RetencoesFederais', ''), 0);

        //Padr�o Nacional
        Servico.Valores.ValorRecebido := StringToFloatDef(INIRec.ReadString(sSecao, 'ValorRecebido', ''), 0);

        // Provedor Infisc
        Servico.Valores.totalAproxTrib := StringToFloatDef(INIRec.ReadString(sSecao, 'totalAproxTrib', ''), 0);
      end;

      sSecao := 'ValoresNFSe';
      if INIRec.SectionExists(sSecao) then
      begin
        ValoresNfse.BaseCalculo := StrToFloatDef(INIRec.ReadString(sSecao, 'BaseCalculo', ''), 0);
        ValoresNfse.Aliquota := StrToFloatDef(INIRec.ReadString(sSecao, 'Aliquota', ''), 0);
        ValoresNfse.ValorLiquidoNfse := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorLiquidoNfse', ''), 0);
        ValoresNfse.ValorIss := StrToFloatDef(INIRec.ReadString(sSecao, 'ValorIss', ''), 0);
      end;

      //Padr�o Nacional
      i := 1;
      while true do
      begin
        sSecao := 'DocumentosDeducoes' + IntToStrZero(i, 3);

        if not INIRec.SectionExists(sSecao) then
          break;

        ItemDocDeducao := Servico.Valores.DocDeducao.New;

        ItemDocDeducao.chNFSe := INIRec.ReadString(sSecao,'chNFSe', '');
        ItemDocDeducao.chNFe := INIRec.ReadString(sSecao, 'chNFe', '');
        ItemDocDeducao.nDocFisc := INIRec.ReadString(sSecao, 'nDocFisc', '');
        ItemDocDeducao.nDoc := INIRec.ReadString(sSecao, 'nDoc', '');
        ItemDocDeducao.tpDedRed := StrTotpDedRed(Ok, INIRec.ReadString(sSecao, 'tpDedRed', '1'));
        ItemDocDeducao.xDescOutDed := INIRec.ReadString(sSecao, 'xDescOutDed', '');
        ItemDocDeducao.dtEmiDoc := INIRec.ReadDate(sSecao, 'dtEmiDoc', Now);
        ItemDocDeducao.vDedutivelRedutivel := StringToFloatDef(INIRec.ReadString(sSecao, 'vDedutivelRedutivel', ''), 0);
        ItemDocDeducao.vDeducaoReducao := StringToFloatDef(INIRec.ReadString(sSecao, 'vDeducaoReducao', ''), 0);

        ItemDocDeducao.NFSeMun.cMunNFSeMun := INIRec.ReadString(sSecao, 'cMunNFSeMun', '');
        ItemDocDeducao.NFSeMun.nNFSeMun := INIRec.ReadString(sSecao, 'nNFSeMun', '');
        ItemDocDeducao.NFSeMun.cVerifNFSeMun := INIRec.ReadString(sSecao, 'cVerifNFSeMun', '');

        ItemDocDeducao.NFNFS.nNFS := INIRec.ReadString(sSecao, 'nNFS', '');
        ItemDocDeducao.NFNFS.modNFS := INIRec.ReadString(sSecao, 'modNFS', '');
        ItemDocDeducao.NFNFS.serieNFS := INIRec.ReadString(sSecao, 'serieNFS', '');

        sSecao := 'DocumentosDeducoesFornecedor' + IntToStrZero(i, 3);
        if INIRec.SectionExists(sSecao) then
        begin
          ItemDocDeducao.fornec.Identificacao.CpfCnpj := INIRec.ReadString(sSecao, 'CNPJCPF', '');
          ItemDocDeducao.fornec.Identificacao.InscricaoMunicipal := INIRec.ReadString(sSecao, 'InscricaoMunicipal', '');
          ItemDocDeducao.fornec.Identificacao.Nif := INIRec.ReadString(sSecao, 'NIF', '');
          ItemDocDeducao.fornec.Identificacao.cNaoNIF := StrToNaoNIF(Ok, INIRec.ReadString(sSecao, 'cNaoNIF', '0'));
          ItemDocDeducao.fornec.Identificacao.CAEPF := INIRec.ReadString(sSecao, 'CAEPF', '');

          ItemDocDeducao.fornec.Endereco.CEP := INIRec.ReadString(sSecao, 'CEP', '');
          ItemDocDeducao.fornec.Endereco.xMunicipio := INIRec.ReadString(sSecao, 'xMunicipio', '');
          ItemDocDeducao.fornec.Endereco.UF := INIRec.ReadString(sSecao, 'UF', '');
          ItemDocDeducao.fornec.Endereco.Endereco := INIRec.ReadString(sSecao, 'Logradouro', '');
          ItemDocDeducao.fornec.Endereco.Numero := INIRec.ReadString(sSecao, 'Numero', '');
          ItemDocDeducao.fornec.Endereco.Complemento := INIRec.ReadString(sSecao, 'Complemento', '');
          ItemDocDeducao.fornec.Endereco.Bairro := INIRec.ReadString(sSecao, 'Bairro', '');

          ItemDocDeducao.fornec.Contato.Telefone := INIRec.ReadString(sSecao, 'Telefone', '');
          ItemDocDeducao.fornec.Contato.Email := INIRec.ReadString(sSecao, 'Email', '');
        end;

        Inc(i);
      end;

      //Padr�o Nacional
      sSecao := 'tribMun';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.Valores.tribMun.tribISSQN := StrTotribISSQN(Ok, INIRec.ReadString(sSecao, 'tribISSQN', '1'));
        Servico.Valores.tribMun.cPaisResult := INIRec.ReadInteger(sSecao, 'cPaisResult', 0);
        Servico.Valores.tribMun.tpBM := StrTotpBM(Ok, INIRec.ReadString(sSecao, 'tpBM', '1'));
        Servico.Valores.tribMun.nBM := INIRec.ReadString(sSecao, 'nBM', '');
        Servico.Valores.tribMun.vRedBCBM := StringToFloatDef(INIRec.ReadString(sSecao, 'vRedBCBM', ''), 0);
        Servico.Valores.tribMun.pRedBCBM := StringToFloatDef(INIRec.ReadString(sSecao, 'pRedBCBM', ''), 0);
        Servico.Valores.tribMun.tpSusp := StrTotpSusp(Ok, INIRec.ReadString(sSecao, 'tpSusp', ''));
        Servico.Valores.tribMun.nProcesso := INIRec.ReadString(sSecao, 'nProcesso', '');
        Servico.Valores.tribMun.tpImunidade := StrTotpImunidade(Ok, INIRec.ReadString(sSecao, 'tpImunidade', ''));
        Servico.Valores.tribMun.pAliq := StringToFloatDef(INIRec.ReadString(sSecao, 'pAliq', ''), 0);
        Servico.Valores.tribMun.tpRetISSQN := StrTotpRetISSQN(Ok, INIRec.ReadString(sSecao, 'tpRetISSQN', ''));
      end;

      //Padr�o Nacional
      sSecao := 'tribFederal';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.Valores.tribFed.CST := StrToCST(Ok, INIRec.ReadString(sSecao, 'CST', ''));
        Servico.Valores.tribFed.vBCPisCofins := StringToFloatDef(INIRec.ReadString(sSecao, 'vBCPisCofins', ''), 0);
        Servico.Valores.tribFed.pAliqPis := StringToFloatDef(INIRec.ReadString(sSecao, 'pAliqPis', ''), 0);
        Servico.Valores.tribFed.pAliqCofins := StringToFloatDef(INIRec.ReadString(sSecao, 'pAliqCofins' ,''), 0);
        Servico.Valores.tribFed.vPis := StringToFloatDef(INIRec.ReadString(sSecao, 'vPis', ''), 0);
        Servico.Valores.tribFed.vCofins := StringToFloatDef(INIRec.ReadString(sSecao, 'vCofins', ''), 0);
        Servico.Valores.tribFed.tpRetPisCofins := StrTotpRetPisCofins(Ok, INIRec.ReadString(sSecao, 'tpRetPisCofins', ''));
        Servico.Valores.tribFed.vRetCP := StringToFloatDef(INIRec.ReadString(sSecao, 'vRetCP', ''), 0);
        Servico.Valores.tribFed.vRetIRRF := StringToFloatDef(INIRec.ReadString(sSecao, 'vRetIRRF', ''), 0);
        Servico.Valores.tribFed.vRetCSLL := StringToFloatDef(INIRec.ReadString(sSecao, 'vRetCSLL', ''), 0);
      end;

      //Padr�o Nacional
      sSecao := 'totTrib';
      if INIRec.SectionExists(sSecao) then
      begin
        Servico.Valores.totTrib.indTotTrib := StrToindTotTrib(Ok, INIRec.ReadString(sSecao, 'indTotTrib', '0'));
        Servico.Valores.totTrib.pTotTribSN := StringToFloatDef(INIRec.ReadString(sSecao, 'pTotTribSN', ''), 0);

        Servico.Valores.totTrib.vTotTribFed := StringToFloatDef(INIRec.ReadString(sSecao, 'vTotTribFed', ''), 0);
        Servico.Valores.totTrib.vTotTribEst := StringToFloatDef(INIRec.ReadString(sSecao, 'vTotTribEst', ''), 0);
        Servico.Valores.totTrib.vTotTribMun := StringToFloatDef(INIRec.ReadString(sSecao, 'vTotTribMun', ''), 0);

        Servico.Valores.totTrib.pTotTribFed := StringToFloatDef(INIRec.ReadString(sSecao, 'pTotTribFed', ''), 0);
        Servico.Valores.totTrib.pTotTribEst := StringToFloatDef(INIRec.ReadString(sSecao, 'pTotTribEst', ''), 0);
        Servico.Valores.totTrib.pTotTribMun := StringToFloatDef(INIRec.ReadString(sSecao, 'pTotTribMun', ''), 0);
      end;

      // Condi��o de Pagamento usado pelo provedor Betha vers�o 1 do Layout da ABRASF
      sSecao := 'CondicaoPagamento';
      if INIRec.SectionExists(sSecao) then
      begin
        CondicaoPagamento.QtdParcela := INIRec.ReadInteger(sSecao, 'QtdParcela', 0);
        // Provedor Publica/IPM/Betha
        CondicaoPagamento.Condicao := FProvider.StrToCondicaoPag(Ok, INIRec.ReadString(sSecao, 'Condicao', 'A_VISTA'));

        // Provedor NFEletronica
        CondicaoPagamento.DataVencimento := INIRec.ReadDate(sSecao, 'DataVencimento', Now);
        CondicaoPagamento.InstrucaoPagamento := INIRec.ReadString(sSecao, 'InstrucaoPagamento', '');
        CondicaoPagamento.CodigoVencimento := INIRec.ReadInteger(sSecao, 'CodigoVencimento', 0);
      end;

      //GeisWeb, ISSCambe, ISSLencois
      sSecao := 'OrgaoGerador';
      if INIRec.SectionExists(sSecao) then
      begin
        OrgaoGerador.CodigoMunicipio := INIRec.ReadString(sSecao, 'CodigoMunicipio', '');
        OrgaoGerador.Uf := INIRec.ReadString(sSecao, 'UF', '');
      end;

      i := 1;
      while true do
      begin
        sSecao := 'Parcelas' + IntToStrZero(i, 2);
        sFim := INIRec.ReadString(sSecao, 'Parcela'  ,'FIM');

        if (sFim = 'FIM') then
          break;

        ItemParcelas := CondicaoPagamento.Parcelas.New;
        ItemParcelas.Parcela := sFim;
        ItemParcelas.DataVencimento := INIRec.ReadDate(sSecao, 'DataVencimento', Now);
        ItemParcelas.Valor := StringToFloatDef(INIRec.ReadString(sSecao, 'Valor', ''), 0);
        ItemParcelas.Condicao := FProvider.StrToCondicaoPag(Ok, INIRec.ReadString(sSecao, 'Condicao', ''));

        Inc(i);
      end;
    end;

    Result := True;
  finally
    INIRec.Free;
  end;
end;

function TNotaFiscal.GerarNFSeIni: string;
var
  I: integer;
  sSecao: string;
  INIRec: TMemIniFile;
  IniNFSe: TStringList;
  FProvider: IACBrNFSeXProvider;
  fornec: TInfoPessoa;
begin
  Result:= '';
  FProvider := TACBrNFSeX(FACBrNFSe).Provider;

  INIRec := TMemIniFile.Create('');
  try
    with FNFSe do
    begin
      //Provedor Infisc - Layout Proprio
      sSecao:= 'IdentificacaoNFSe';

      if tpXML = txmlRPS then
        INIRec.WriteString(sSecao, 'TipoXML', 'RPS')
      else
        INIRec.WriteString(sSecao, 'TipoXML', 'NFSE');

      INIRec.WriteString(sSecao, 'Numero', Numero);
      INIRec.WriteString(sSecao, 'NumeroLote', NumeroLote);
      INIRec.WriteString(sSecao, 'StatusNFSe', StatusNFSeToStr(SituacaoNfse));

      if CodigoVerificacao <> '' then
        INIRec.WriteString(sSecao, 'CodigoVerificacao', CodigoVerificacao);

      if InfNFSe.Id <> '' then
        INIRec.WriteString(sSecao, 'ID', InfNFse.ID);

      if NfseSubstituida <> '' then
        INIRec.WriteString(sSecao, 'NfseSubstituida', NfseSubstituida);

      if NfseSubstituidora <> '' then
        INIRec.WriteString(sSecao, 'NfseSubstituidora', NfseSubstituidora);

      INIRec.WriteFloat(sSecao, 'ValorCredito', ValorCredito);
      INIRec.WriteString(sSecao, 'ChaveAcesso', ChaveAcesso);
      INIRec.WriteString(sSecao, 'Link', Link);
      INIRec.WriteString(sSecao, 'DescricaoCodigoTributacaoMunicipio', DescricaoCodigoTributacaoMunicipio);
      INIRec.WriteString(sSecao, 'refNF', refNF);
      INIRec.WriteString(sSecao, 'TipoEmissao', TipoEmissaoToStr(TipoEmissao));
      INIRec.WriteString(sSecao, 'EmpreitadaGlobal', EmpreitadaGlobalToStr(EmpreitadaGlobal));
      INIRec.WriteString(sSecao, 'ModeloNFSe', ModeloNFSe);
      INIRec.WriteString(sSecao, 'Canhoto', CanhotoToStr(Canhoto));

      if Trim(Assinatura) <> '' then
        INIRec.WriteString(sSecao, 'Assinatura', Assinatura);

      sSecao:= 'IdentificacaoRps';
      INIRec.WriteString(sSecao, 'SituacaoTrib', FProvider.SituacaoTribToStr(SituacaoTrib));
      INIRec.WriteString(sSecao, 'Producao', FProvider.SimNaoToStr(Producao));
      INIRec.WriteString(sSecao, 'Status', FProvider.StatusRPSToStr(StatusRps));
      INIRec.WriteString(sSecao, 'OutrasInformacoes', StringReplace(OutrasInformacoes, sLineBreak, FProvider.ConfigGeral.QuebradeLinha, [rfReplaceAll]));

      //Provedores CTA, ISSBarueri, ISSSDSF, ISSSaoPaulo, Simple e SmarAPD.
      INIRec.WriteString(sSecao, 'TipoTributacaoRps', FProvider.TipoTributacaoRPSToStr(TipoTributacaoRPS));

      INIRec.WriteString(sSecao, 'TipoRecolhimento', TipoRecolhimento);

      // Provedores ISSDSF e Siat
      INIRec.WriteString(sSecao, 'SeriePrestacao', SeriePrestacao);
      INIRec.WriteString(sSecao, 'IdentificacaoRemessa', IdentificacaoRemessa);
      INIRec.WriteString(sSecao, 'Numero', IdentificacaoRps.Numero);
      INIRec.WriteString(sSecao, 'Serie', IdentificacaoRps.Serie);
      INIRec.WriteString(sSecao, 'Tipo', FProvider.TipoRPSToStr(IdentificacaoRps.Tipo));

      if DataEmissao > 0 then
        INIRec.WriteDateTime(sSecao, 'DataEmissao', DataEmissao)
      else
        INIRec.WriteDateTime(sSecao, 'DataEmissao', Now);

      if DataEmissaoRps > 0 then
        INIRec.WriteDateTime(sSecao, 'DataEmissaoRps', DataEmissaoRps);

      if Competencia > 0 then
        INIRec.WriteDate(sSecao, 'Competencia', Competencia)
      else
        IniRec.WriteDate(sSecao, 'Competencia', Now);

      if Vencimento > 0 then
        INIRec.WriteDate(sSecao, 'Vencimento', Vencimento)
      else
        INIRec.WriteDate(sSecao, 'Vencimento', Now);

      if DataPagamento > 0 then
        INIRec.WriteDate(sSecao, 'DataPagamento', DataPagamento)
      else
        INIRec.WriteDate(sSecao, 'DataPagamento', Now);

      if dhRecebimento > 0 then
        INIRec.WriteDate(sSecao, 'dhRecebimento', dhRecebimento)
      else
        INIRec.WriteDate(sSecao, 'dhRecebimento', Now);

      INIRec.WriteString(sSecao, 'NaturezaOperacao', NaturezaOperacaoToStr(NaturezaOperacao));

      // Provedor Tecnos
      INIRec.WriteFloat(sSecao, 'PercentualCargaTributaria', PercentualCargaTributaria);
      INIRec.WriteFloat(sSecao, 'ValorCargaTributaria', ValorCargaTributaria);
      INIRec.WriteFloat(sSecao, 'PercentualCargaTributariaMunicipal', PercentualCargaTributariaMunicipal);
      INIRec.WriteFloat(sSecao, 'ValorCargaTributariaMunicipal', ValorCargaTributariaMunicipal);
      INIRec.WriteFloat(sSecao, 'PercentualCargaTributariaEstadual', PercentualCargaTributariaEstadual);
      INIRec.WriteFloat(sSecao, 'ValorCargaTributariaEstadual', ValorCargaTributariaEstadual);

      //Padr�o Nacional
      INIRec.WriteString(sSecao, 'verAplic', verAplic);
      INIRec.WriteString(sSecao, 'tpEmit', tpEmitToStr(tpEmit));

      //Provedor Governa
      INIRec.WriteString(sSecao, 'RegRec', RegRecToStr(RegRec));
      INIRec.WriteString(sSecao, 'FrmRec', FrmRecToStr(FrmRec));

      INIRec.WriteString(sSecao, 'InformacoesComplementares', InformacoesComplementares);
      INIRec.WriteInteger(sSecao, 'Situacao', Situacao);
      INIRec.WriteString(sSecao, 'EqptoRecibo', EqptoRecibo);
      INIRec.WriteInteger(sSecao, 'TipoNota', TipoNota);
      //Tecnos
      INIRec.WriteString(sSecao, 'SiglaUF', SiglaUF);
      INIRec.WriteInteger(sSecao, 'EspecieDocumento', EspecieDocumento);
      INIRec.WriteInteger(sSecao, 'SerieTalonario', SerieTalonario);
      INIRec.WriteInteger(sSecao, 'FormaPagamento', FormaPagamento);
      INIRec.WriteInteger(sSecao, 'NumeroParcelas', NumeroParcelas);
      INIRec.WriteInteger(sSecao, 'id_sis_legado', id_sis_legado);
      INIRec.WriteString(sSecao, 'DeducaoMateriais', FProvider.SimNaoToStr(DeducaoMateriais));

      if RpsSubstituido.Numero <> '' then
      begin
        sSecao:= 'RpsSubstituido';
        INIRec.WriteString(sSecao, 'Numero', RpsSubstituido.Numero);
        INIRec.WriteString(sSecao, 'Serie', RpsSubstituido.Serie);
        INIRec.WriteString(sSecao, 'Tipo', FProvider.TipoRPSToStr(RpsSubstituido.Tipo));
      end;

      //Padr�o Nacional
      if Trim(subst.chSubstda) <> '' then
      begin
        sSecao := 'NFSeSubstituicao';
        INIRec.WriteString(sSecao, 'chSubstda', subst.chSubstda);
        INIRec.WriteString(sSecao, 'cMotivo', cMotivoToStr(subst.cMotivo));
        INIRec.WriteString(sSecao, 'xMotivo', subst.xMotivo);
      end;

      if (NfseCancelamento.DataHora > 0) or (Trim(MotivoCancelamento) <> '')then
      begin
        sSecao := 'NFSeCancelamento';
        INIRec.WriteString(sSecao, 'MotivoCancelamento', MotivoCancelamento);
        INIRec.WriteString(sSecao, 'JustificativaCancelamento', JustificativaCancelamento);
        INIRec.WriteString(sSecao, 'CodigoCancelamento', CodigoCancelamento);
        INIRec.WriteString(sSecao, 'NumeroNFSe', NFSeCancelamento.Pedido.IdentificacaoNfse.Numero);
        INIRec.WriteString(sSecao, 'CNPJ', NfseCancelamento.Pedido.IdentificacaoNfse.Cnpj);
        INIRec.WriteString(sSecao, 'InscricaoMunicipal', NFSeCancelamento.Pedido.IdentificacaoNfse.InscricaoMunicipal);
        INIRec.WriteString(sSecao, 'CodigoMunicipio', NFSeCancelamento.Pedido.IdentificacaoNfse.CodigoMunicipio);
        INIRec.WriteString(sSecao, 'CodCancel', NfseCancelamento.Pedido.CodigoCancelamento);
        INIRec.WriteBool(sSecao, 'Sucesso', NFSeCancelamento.Sucesso);
        INIRec.WriteDateTime(sSecao, 'DataHora', NfSeCancelamento.DataHora);
      end;

      sSecao:= 'Prestador';
      INIRec.WriteString(sSecao, 'Regime', FProvider.RegimeEspecialTributacaoToStr(RegimeEspecialTributacao));
      INIRec.WriteString(sSecao, 'OptanteSN', FProvider.SimNaoToStr(OptanteSimplesNacional));
      INIRec.WriteString(sSecao, 'opSimpNac', OptanteSNToStr(OptanteSN));
      INIRec.WriteString(sSecao, 'OptanteMEISimei', FProvider.SimNaoToStr(OptanteMEISimei));
      if DataOptanteSimplesNacional > 0 then
        INIRec.WriteDateTime(sSecao, 'DataOptanteSimplesNacional', DataOptanteSimplesNacional);
      INIRec.WriteString(sSecao, 'crc', Prestador.crc);
      INIRec.WriteString(sSecao, 'crc_estado', Prestador.crc_estado);
      INIRec.WriteString(sSecao, 'IncentivadorCultural', FProvider.SimNaoToStr(IncentivadorCultural));
      INIRec.WriteString(sSecao, 'CNPJ', Prestador.IdentificacaoPrestador.CpfCnpj);
      INIRec.WriteString(sSecao, 'InscricaoMunicipal', Prestador.IdentificacaoPrestador.InscricaoMunicipal);
      INIRec.WriteString(sSecao, 'RegimeApuracaoSN', RegimeApuracaoSNToStr(RegimeApuracaoSN));
      INIRec.WriteString(sSecao, 'InscricaoEstadual', Prestador.IdentificacaoPrestador.InscricaoEstadual);
      INIRec.WriteString(sSecao, 'NIF', Prestador.IdentificacaoPrestador.NIF);
      INIRec.WriteString(sSecao, 'cNaoNIF', NaoNIFToStr(Prestador.IdentificacaoPrestador.cNaoNIF));
      INIRec.WriteString(sSecao, 'CAEPF', Prestador.IdentificacaoPrestador.CAEPF);
      INIRec.WriteString(sSecao, 'TipoPessoa', FProvider.TipoPessoaToStr(Prestador.IdentificacaoPrestador.Tipo));

      // Para o provedor ISSDigital deve-se informar tambem:
      INIRec.WriteString(sSecao, 'RazaoSocial', Prestador.RazaoSocial);
      INIRec.WriteString(sSecao, 'NomeFantasia', Prestador.NomeFantasia);
      INIRec.WriteString(sSecao, 'TipoLogradouro', Prestador.Endereco.TipoLogradouro);
      INIRec.WriteString(sSecao, 'Logradouro', Prestador.Endereco.Endereco);
      INIRec.WriteString(sSecao, 'Numero', Prestador.Endereco.Numero);
      INIRec.WriteString(sSecao, 'Complemento', Prestador.Endereco.Complemento);
      INIRec.WriteString(sSecao, 'Bairro', Prestador.Endereco.Bairro);
      INIRec.WriteString(sSecao, 'CodigoMunicipio', Prestador.Endereco.CodigoMunicipio);
      INIRec.WriteString(sSecao, 'xMunicipio', Prestador.Endereco.xMunicipio);
      INIRec.WriteString(sSecao, 'UF',  Prestador.Endereco.UF);
      INIRec.WriteInteger(sSecao, 'CodigoPais', Prestador.Endereco.CodigoPais);
      INIRec.WriteString(sSecao, 'xPais', Prestador.Endereco.xPais);
      INIRec.WriteString(sSecao, 'CEP', Prestador.Endereco.CEP);
      INIRec.WriteString(sSecao, 'DDD', Prestador.Contato.DDD);
      INIRec.WriteString(sSecao, 'Telefone', Prestador.Contato.Telefone);
      INIRec.WriteString(sSecao, 'Email', Prestador.Contato.Email);
      INIRec.WriteString(sSecao, 'xSite', Prestador.Contato.xSite);

      // Para o provedor WebFisco
      if Prestador.Anexo <> '' then
        INIRec.WriteString(sSecao, 'Anexo', Prestador.Anexo);

      if Prestador.ValorReceitaBruta > 0 then
        INIRec.WriteFloat(sSecao, 'ValorReceitaBruta', Prestador.ValorReceitaBruta);

      if Prestador.DataInicioAtividade > 0 then
        INIRec.WriteDate(sSecao, 'DataInicioAtividade', Prestador.DataInicioAtividade);

      sSecao:= 'Tomador';
      INIRec.WriteString(sSecao, 'Tipo', FProvider.TipoPessoaToStr(Tomador.IdentificacaoTomador.Tipo));
      INIRec.WriteString(sSecao, 'CNPJCPF', Tomador.IdentificacaoTomador.CpfCnpj);
      INIRec.WriteString(sSecao, 'InscricaoMunicipal', Tomador.IdentificacaoTomador.InscricaoMunicipal);
      INIRec.WriteString(sSecao, 'NIF', Tomador.IdentificacaoTomador.NIF);
      INIRec.WriteString(sSecao, 'cNaoNIF', NaoNIFToStr(Tomador.IdentificacaoTomador.cNaoNIF));
      INIRec.WriteString(sSecao, 'CAEPF', Tomador.IdentificacaoTomador.CAEPF);
      INIRec.WriteString(sSecao, 'DocEstrangeiro', Tomador.IdentificacaoTomador.DocEstrangeiro);
      //Exigido pelo provedor Equiplano
      INIRec.WriteString(sSecao, 'InscricaoEstadual', Tomador.IdentificacaoTomador.InscricaoEstadual);
      INIRec.WriteString(sSecao, 'RazaoSocial', Tomador.RazaoSocial);
      INIRec.WriteString(sSecao, 'NomeFantasia', Tomador.NomeFantasia);

      INIRec.WriteString(sSecao, 'EnderecoInformado', FProvider.SimNaoOpcToStr(Tomador.Endereco.EnderecoInformado));
      INIRec.WriteString(sSecao, 'TipoLogradouro', Tomador.Endereco.TipoLogradouro);
      INIRec.WriteString(sSecao, 'Logradouro', Tomador.Endereco.Endereco);
      INIRec.WriteString(sSecao, 'Numero', Tomador.Endereco.Numero);
      INIRec.WriteString(sSecao, 'Complemento', Tomador.Endereco.Complemento);
      INIRec.WriteString(sSecao, 'Bairro', Tomador.Endereco.Bairro);
      INIRec.WriteString(sSecao, 'TipoBairro', Tomador.Endereco.TipoBairro);
      INIRec.WriteString(sSecao, 'CodigoMunicipio', Tomador.Endereco.CodigoMunicipio);
      INIRec.WriteString(sSecao, 'xMunicipio', Tomador.Endereco.xMunicipio);
      INIRec.WriteString(sSecao, 'UF', Tomador.Endereco.UF);
      INIRec.WriteInteger(sSecao, 'CodigoPais', Tomador.Endereco.CodigoPais);
      INIRec.WriteString(sSecao, 'CEP', Tomador.Endereco.CEP);
      INIRec.WriteString(sSecao, 'PontoReferencia', Tomador.Endereco.PontoReferencia);
      //Exigido pelo provedor Equiplano
      INIRec.WriteString(sSecao, 'xPais', Tomador.Endereco.xPais);
      INIRec.WriteString(sSecao, 'DDD', Tomador.Contato.DDD);
      INIRec.WriteString(sSecao, 'TipoTelefone', Tomador.Contato.TipoTelefone);
      INIRec.WriteString(sSecao, 'Telefone', Tomador.Contato.Telefone);
      INIRec.WriteString(sSecao, 'Email', Tomador.Contato.Email);
      INIRec.WriteString(sSecao, 'AtualizaTomador', FProvider.SimNaoToStr(Tomador.AtualizaTomador));
      INIRec.WriteString(sSecao, 'TomadorExterior', FProvider.SimNaoToStr(Tomador.TomadorExterior));

      if Intermediario.Identificacao.CpfCnpj <> '' then
      begin
        sSecao:= 'Intermediario';
        INIRec.WriteString(sSecao, 'CNPJCPF', Intermediario.Identificacao.CpfCnpj);
        INIRec.WriteString(sSecao, 'InscricaoMunicipal', Intermediario.Identificacao.InscricaoMunicipal);
        INIRec.WriteString(sSecao, 'NIF', Intermediario.Identificacao.NIF);
        INIRec.WriteString(sSecao, 'cNaoNIF', NaoNIFToStr(Intermediario.Identificacao.cNaoNIF));
        INIRec.WriteString(sSecao, 'CAEPF', Intermediario.Identificacao.CAEPF);
        INIRec.WriteString(sSecao, 'RazaoSocial', Intermediario.RazaoSocial);
        INIRec.WriteString(sSecao, 'IssRetido', FProvider.SituacaoTributariaToStr(Intermediario.IssRetido));

        if (Intermediario.Endereco.Endereco <> '') or (Intermediario.Endereco.CEP <> '')then
        begin
          INIRec.WriteString(sSecao, 'Logradouro', Intermediario.Endereco.Endereco);
          INIRec.WriteString(sSecao, 'Numero', Intermediario.Endereco.Numero);
          INIRec.WriteString(sSecao, 'Complemento', Intermediario.Endereco.Complemento);
          INIRec.WriteString(sSecao, 'Bairro', Intermediario.Endereco.Bairro);
          INIRec.WriteString(sSecao, 'CodigoMunicipio', Intermediario.Endereco.CodigoMunicipio);
          INIRec.WriteString(sSecao, 'xMunicipio', Intermediario.Endereco.xMunicipio);
          INIRec.WriteString(sSecao, 'UF', Intermediario.Endereco.UF);
          INIRec.WriteInteger(sSecao, 'CodigoPais', Intermediario.Endereco.CodigoPais);
          INIRec.WriteString(sSecao, 'CEP', Intermediario.Endereco.CEP);
          INIRec.WriteString(sSecao, 'xPais', Intermediario.Endereco.xPais);
        end;

        INIRec.WriteString(sSecao, 'Telefone', Intermediario.Contato.Telefone);
        INIRec.WriteString(sSecao, 'Email', Intermediario.Contato.Email);
      end;

      if Trim(Transportadora.xCpfCnpjTrans) <> '' then
      begin
        //SmarAPD, Infisc.
        sSecao := 'Transportadora';
        INIRec.WriteString(sSecao, 'xNomeTrans', Transportadora.xNomeTrans);
        INIRec.WriteString(sSecao, 'xCpfCnpjTrans', Transportadora.xCpfCnpjTrans);
        INIRec.WriteString(sSecao, 'xInscEstTrans', Transportadora.xInscEstTrans);
        INIRec.WriteString(sSecao, 'xPlacaTrans', Transportadora.xPlacaTrans);
        INIRec.WriteString(sSecao, 'xEndTrans', Transportadora.xEndTrans);
        INIRec.WriteInteger(sSecao, 'cMunTrans', Transportadora.cMunTrans);
        INIRec.WriteString(sSecao, 'xMunTrans', Transportadora.xMunTrans);
        INIRec.WriteString(sSecao, 'xUFTrans', Transportadora.xUFTrans);
        INIRec.WriteString(sSecao, 'xPaisTrans', Transportadora.xPaisTrans);
        INIRec.WriteString(sSecao, 'vTipoFreteTrans', TipoFreteToStr(Transportadora.vTipoFreteTrans));
      end;

      if ConstrucaoCivil.CodigoObra <> '' then
      begin
        sSecao:= 'ConstrucaoCivil';
        INIRec.WriteString(sSecao, 'CodigoObra', ConstrucaoCivil.CodigoObra);
        INIRec.WriteString(sSecao, 'Art', ConstrucaoCivil.Art);
        INIRec.WriteString(sSecao, 'nCei', ConstrucaoCivil.nCei);
        INIRec.WriteString(sSecao, 'nProj', ConstrucaoCivil.nProj);
        INIRec.WriteString(sSecao, 'nMatri', ConstrucaoCivil.nMatri);
        INIRec.WriteString(sSecao, 'nNumeroEncapsulamento', ConstrucaoCivil.nNumeroEncapsulamento);
        //Padr�o Nacional
        INIRec.WriteString(sSecao, 'inscImobFisc', ConstrucaoCivil.inscImobFisc);

        //Padr�o Nacional
        if (ConstrucaoCivil.Endereco.Endereco <> '') or (ConstrucaoCivil.Endereco.CEP <> '') then
        begin
          INIRec.WriteString(sSecao, 'CEP', ConstrucaoCivil.Endereco.CEP);
          INIRec.WriteString(sSecao, 'xMunicipio', ConstrucaoCivil.Endereco.XMunicipio);
          INIRec.WriteString(sSecao, 'UF', ConstrucaoCivil.Endereco.UF);
          INIRec.WriteString(sSecao, 'Logradouro', ConstrucaoCivil.Endereco.Endereco);
          INIRec.WriteString(sSecao, 'Numero', ConstrucaoCivil.Endereco.Numero);
          INIRec.WriteString(sSecao, 'Complemento', ConstrucaoCivil.Endereco.Complemento);
          INIRec.WriteString(sSecao, 'Bairro', ConstrucaoCivil.Endereco.Bairro);
        end;
      end;

      sSecao:= 'Servico';
      INIRec.WriteString(sSecao, 'ItemListaServico', Servico.ItemListaServico);
      INIRec.WriteString(sSecao, 'xItemListaServico', Servico.xItemListaServico);
      INIRec.WriteString(sSecao, 'CodigoCnae', Servico.CodigoCnae);
      INIRec.WriteString(sSecao, 'CodigoTributacaoMunicipio', Servico.CodigoTributacaoMunicipio);
      INIRec.WriteString(sSecao, 'xCodigoTributacaoMunicipio', Servico.xCodigoTributacaoMunicipio);
      INIRec.WriteString(sSecao, 'Discriminacao', ChangeLineBreak(Servico.Discriminacao, FProvider.ConfigGeral.QuebradeLinha));
      INIRec.WriteString(sSecao, 'Descricao', ChangeLineBreak(Servico.Descricao, FProvider.ConfigGeral.QuebradeLinha));
      INIRec.WriteString(sSecao, 'CodigoMunicipio', Servico.CodigoMunicipio);
      INIRec.WriteInteger(sSecao, 'CodigoPais', Servico.CodigoPais);
      INIRec.WriteString(sSecao, 'ExigibilidadeISS', FProvider.ExigibilidadeISSToStr(Servico.ExigibilidadeISS));
      INIRec.WriteString(sSecao, 'IdentifNaoExigibilidade', Servico.IdentifNaoExigibilidade);
      INIRec.WriteInteger(sSecao, 'MunicipioIncidencia', Servico.MunicipioIncidencia);
      INIRec.WriteString(sSecao, 'xMunicipioIncidencia',Servico.xMunicipioIncidencia);
      INIRec.WriteString(sSecao, 'NumeroProcesso', Servico.NumeroProcesso);
      INIRec.WriteString(sSecao, 'MunicipioPrestacaoServico', Servico.MunicipioPrestacaoServico);
      INIRec.WriteString(sSecao, 'UFPrestacao', Servico.UFPrestacao);
      INIRec.WriteString(sSecao, 'ResponsavelRetencao', FProvider.ResponsavelRetencaoToStr(Servico.ResponsavelRetencao));
      INIRec.WriteString(sSecao, 'TipoLancamento', TipoLancamentoToStr(Servico.TipoLancamento));
      INIRec.WriteFloat(sSecao,'ValorTotalRecebido', Servico.ValorTotalRecebido);
      //Provedor ISSDSF
      INIRec.WriteString(sSecao, 'Operacao', OperacaoToStr(Servico.Operacao));
      INIRec.WriteString(sSecao, 'Tributacao', FProvider.TributacaoToStr(Servico.Tributacao));
      //Padr�o Nacional e IssNet
      INIRec.WriteString(sSecao, 'CodigoNBS', Servico.CodigoNBS);
      INIRec.WriteString(sSecao, 'CodigoInterContr', Servico.CodigoInterContr);

      // Provedor SoftPlan
      INIRec.WriteString(sSecao, 'CFPS', '');

      // Provedor Giap Informa��es sobre o Endere�o da Presta��o de Servi�o
      INIRec.WriteString(sSecao, 'Bairro', Servico.Endereco.Bairro);
      INIRec.WriteString(sSecao, 'CEP', Servico.Endereco.CEP);
      INIRec.WriteString(sSecao, 'xMunicipio', Servico.Endereco.xMunicipio);
      INIRec.WriteString(sSecao, 'Complemento', Servico.Endereco.Complemento);
      INIRec.WriteString(sSecao, 'Logradouro', Servico.Endereco.Endereco);
      INIRec.WriteString(sSecao, 'Numero', Servico.Endereco.Numero);
      INIRec.WriteString(sSecao, 'xPais', Servico.Endereco.xPais);
      INIRec.WriteString(sSecao, 'UF', Servico.Endereco.UF);

      //IssSaoPaulo
      INIRec.WriteFloat(sSecao, 'ValorTotalRecebido', Servico.ValorTotalRecebido);
      INIRec.WriteFloat(sSecao, 'ValorCargaTributaria', Servico.ValorCargaTributaria);
      INIRec.WriteFloat(sSecao, 'PercentualCargaTributaria', Servico.PercentualCargaTributaria);
      INIRec.WriteString(sSecao, 'FonteCargaTributaria', Servico.FonteCargaTributaria);

      INIRec.WriteString(sSecao,'LocalPrestacao', LocalPrestacaoToStr(Servico.LocalPrestacao));
      INIRec.WriteBool(sSecao, 'PrestadoEmViasPublicas',Servico.PrestadoEmViasPublicas);

      //Provedor Megasoft
      INIRec.WriteString(sSecao, 'InfAdicional', Servico.InfAdicional);
      INIRec.WriteString(sSecao, 'xFormaPagamento', Servico.xFormaPagamento);

      for I := 0 to Servico.Deducao.Count - 1 do
      begin
        sSecao := 'Deducoes' + IntToStrZero(I + 1, 3);
        INIRec.WriteString(sSecao, 'DeducaoPor', FProvider.DeducaoPorToStr(Servico.Deducao[I].DeducaoPor));
        INIRec.WriteString(sSecao, 'TipoDeducao', FProvider.TipoDeducaoToStr(Servico.Deducao[I].TipoDeducao));
        INIRec.WriteString(sSecao, 'CpfCnpjReferencia', Servico.Deducao[I].CpfCnpjReferencia);
        INIRec.WriteString(sSecao, 'NumeroNFReferencia', Servico.Deducao[I].NumeroNFReferencia);
        INIRec.WriteFloat(sSecao, 'ValorTotalReferencia', Servico.Deducao[I].ValorTotalReferencia);
        INIRec.WriteFloat(sSecao, 'PercentualDeduzir', Servico.Deducao[I].PercentualDeduzir);
        INIRec.WriteFloat(sSecao, 'ValorDeduzir', Servico.Deducao[I].ValorDeduzir);
      end;

      //Quartos, ussado provedor iiBrasil
      for I := 0 to Quartos.Count - 1 do
      begin
        sSecao := 'Quartos' + IntToStrZero(I + 1, 3);
        INIRec.WriteInteger(sSecao, 'CodigoInternoQuarto', Quartos[I].CodigoInternoQuarto);
        INIRec.WriteInteger(sSecao, 'QtdHospedes', Quartos[I].QtdHospedes);
        INIRec.WriteDateTime(sSecao, 'CheckIn', Quartos[I].CheckIn);
        INIRec.WriteFloat(sSecao, 'QtdDiarias', Quartos[I].ValorDiaria);
      end;

      for I := 0 to email.Count - 1 do
      begin
        sSecao := 'Email' + IntToStrZero(I + 1, 1);
        INIRec.WriteString(sSecao, 'emailCC', email[I].emailCC);
      end;

      //IPM
      for I := 0 to Genericos.Count - 1 do
      begin
        sSecao := 'Genericos' + IntToStrZero(I + 1, 1);
        INIRec.WriteString(sSecao, 'Titulo', Genericos[I].Titulo);
        INIRec.WriteString(sSecao, 'Descricao', Genericos[I].Descricao);
      end;

      for I := 0 to Servico.Imposto.Count - 1 do
      begin
        sSecao := 'Impostos' + IntToStrZero(I + 1, 3);
        INIRec.WriteInteger(sSecao, 'Codigo', Servico.Imposto[I].Codigo);
        INIRec.WriteString(sSecao, 'Descricao', Servico.Imposto[I].Descricao);
        INIRec.WriteFloat(sSecao, 'Aliquota', Servico.Imposto[I].Aliquota);
        INIRec.WriteFloat(sSecao, 'Valor', Servico.Imposto[I].Valor);
      end;

      for I := 0 to Despesa.Count - 1 do
      begin
        sSecao := 'Despesas' + IntToStrZero(I + 1, 3);
        INIRec.WriteString(sSecao, 'nItemDesp', Despesa.Items[I].nItemDesp);
        INIRec.WriteString(sSecao, 'xDesp', Despesa.Items[I].xDesp);
        INIRec.WriteDateTime(sSecao, 'dDesp', Despesa.Items[I].dDesp);
        INIRec.WriteFloat(sSecao, 'vDesp', Despesa.Items[I].vDesp);
      end;

      //Lista de Itens, xxx pode variar de 001-999
      for I := 0 to Servico.ItemServico.Count - 1 do
      begin
        sSecao:= 'Itens' + IntToStrZero(I + 1, 3);

        INIRec.WriteString(sSecao, 'Descricao', ChangeLineBreak(Servico.ItemServico.Items[I].Descricao, FProvider.ConfigGeral.QuebradeLinha));
        INIRec.WriteString(sSecao, 'CodServico', Servico.ItemServico.Items[I].CodServ);
        INIRec.WriteString(sSecao, 'codLCServico', Servico.ItemServico.Items[I].CodLCServ);
        INIRec.WriteString(sSecao, 'CodigoCnae', Servico.ItemServico.Items[I].CodigoCnae);
        INIRec.WriteString(sSecao, 'ItemListaServico', Servico.ItemServico.Items[I].ItemListaServico);
        INIRec.WriteString(sSecao, 'xItemListaServico', Servico.ItemServico.Items[I].xItemListaServico);
        INIRec.WriteFloat(sSecao, 'Quantidade', Servico.ItemServico.Items[I].Quantidade);
        INIRec.WriteFloat(sSecao, 'ValorUnitario', Servico.ItemServico.Items[I].ValorUnitario);
        INIRec.WriteFloat(sSecao, 'QtdeDiaria', Servico.ItemServico.Items[I].QtdeDiaria);
        INIRec.WriteFloat(sSecao, 'ValorTaxaTurismo', Servico.ItemServico.Items[I].ValorTaxaTurismo);
        INIRec.WriteFloat(sSecao, 'ValorDeducoes', Servico.ItemServico.Items[I].ValorDeducoes);
        INIRec.WriteString(sSecao, 'xJustDeducao', Servico.ItemServico.Items[I].xJustDeducao);
        INIRec.WriteFloat(sSecao, 'AliqReducao', Servico.ItemServico.Items[I].AliqReducao);
        INIRec.WriteFloat(sSecao, 'ValorReducao', Servico.ItemServico.Items[I].ValorReducao);
        INIRec.WriteFloat(sSecao, 'ValorIss', Servico.ItemServico.Items[I].ValorISS);
        INIRec.WriteFloat(sSecao, 'Aliquota', Servico.ItemServico.Items[I].Aliquota);
        INIRec.WriteFloat(sSecao, 'BaseCalculo', Servico.ItemServico.Items[I].BaseCalculo);
        INIRec.WriteFloat(sSecao, 'DescontoIncondicionado', Servico.ItemServico.Items[I].DescontoIncondicionado);
        INIRec.WriteFloat(sSecao, 'DescontoCondicionado', Servico.ItemServico.Items[I].DescontoCondicionado);
        INIRec.WriteFloat(sSecao, 'ValorTotal', Servico.ItemServico.Items[I].ValorTotal);
        INIRec.WriteString(sSecao, 'Tributavel', FProvider.SimNaoToStr(Servico.ItemServico.Items[I].Tributavel));
        INIRec.WriteString(sSecao, 'TipoUnidade', UnidadeToStr(Servico.ItemServico.Items[I].TipoUnidade));
        INIRec.WriteString(sSecao, 'Unidade', Servico.ItemServico.Items[I].Unidade);
        INIRec.WriteFloat(sSecao, 'ValorISSRetido', Servico.ItemServico.Items[I].ValorISSRetido);
        INIRec.WriteFloat(sSecao, 'AliqISSST', Servico.ItemServico.Items[I].AliqISSST);
        INIRec.WriteFloat(sSecao, 'ValorISSST', Servico.ItemServico.Items[I].ValorISSST);
        INIRec.WriteFloat(sSecao, 'ValorBCCSLL', Servico.ItemServico.Items[I].ValorBCCSLL);
        INIRec.WriteFloat(sSecao, 'AliqRetCSLL', Servico.ItemServico.Items[I].AliqRetCSLL);
        INIRec.WriteFloat(sSecao, 'ValorCSLL', Servico.ItemServico.Items[I].ValorCSLL);
        INIRec.WriteFloat(sSecao, 'ValorBCPIS', Servico.ItemServico.Items[I].ValorBCPIS);
        INIRec.WriteFloat(sSecao, 'AliqRetPIS', Servico.ItemServico.Items[I].AliqRetPIS);
        INIRec.WriteFloat(sSecao, 'ValorPIS', Servico.ItemServico.Items[I].ValorPIS);
        INIRec.WriteFloat(sSecao, 'ValorBCCOFINS', Servico.ItemServico.Items[I].ValorBCCOFINS);
        INIRec.WriteFloat(sSecao, 'AliqRetCOFINS', Servico.ItemServico.Items[I].AliqRetCOFINS);
        INIRec.WriteFloat(sSecao, 'ValorCOFINS', Servico.ItemServico.Items[I].ValorCOFINS);
        INIRec.WriteFloat(sSecao, 'ValorBCINSS', Servico.ItemServico.Items[I].ValorBCINSS);
        INIRec.WriteFloat(sSecao, 'AliqRetINSS', Servico.ItemServico.Items[I].AliqRetINSS);
        INIRec.WriteFloat(sSecao, 'ValorINSS', Servico.ItemServico.Items[I].ValorINSS);
        INIRec.WriteFloat(sSecao, 'ValorBCRetIRRF', Servico.ItemServico.Items[I].ValorBCRetIRRF);
        INIRec.WriteFloat(sSecao, 'AliqRetIRRF', Servico.ItemServico.Items[I].AliqRetIRRF);
        INIRec.WriteFloat(sSecao, 'ValorIRRF', Servico.ItemServico.Items[I].ValorIRRF);
        INIRec.WriteString(sSecao, 'TribMunPrestador', FProvider.SimNaoToStr(Servico.ItemServico.Items[I].TribMunPrestador));
        INIRec.WriteString(sSecao, 'CodMunPrestacao', Servico.ItemServico.Items[I].CodMunPrestacao);
        INIRec.WriteInteger(sSecao, 'SituacaoTributaria', Servico.ItemServico.Items[I].SituacaoTributaria);
        INIRec.WriteString(sSecao, 'CodCNO', Servico.ItemServico.Items[I].CodCNO);
        INIRec.WriteFloat(sSecao, 'ValorTributavel', Servico.ItemServico.Items[I].ValorTributavel);
        INIRec.WriteString(sSecao, 'idCnae', Servico.ItemServico.Items[I].idCnae);

        //Provedor Elotech
        sSecao := 'DadosDeducao' + IntToStrZero(I + 1, 3);
        INIRec.WriteString(sSecao, 'TipoDeducao', FProvider.TipoDeducaoToStr(Servico.ItemServico.Items[I].DadosDeducao.TipoDeducao));
        INIRec.WriteString(sSecao, 'CpfCnpj', Servico.ItemServico.Items[I].DadosDeducao.CpfCnpj);
        INIRec.WriteString(sSecao, 'NumeroNotaFiscalReferencia', Servico.ItemServico.Items[I].DadosDeducao.NumeroNotaFiscalReferencia);
        INIRec.WriteFloat(sSecao, 'ValorTotalNotaFiscal', Servico.ItemServico.Items[I].DadosDeducao.ValorTotalNotaFiscal);
        INIRec.WriteFloat(sSecao, 'PercentualADeduzir', Servico.ItemServico.Items[I].DadosDeducao.PercentualADeduzir);
        INIRec.WriteFloat(sSecao, 'ValorADeduzir', Servico.ItemServico.Items[I].DadosDeducao.ValorADeduzir);

        //Provedor Agili
        sSecao := 'DadosProssionalParceiro' + IntToStrZero(I + 1, 3);
        INIRec.WriteString(sSecao, 'CpfCnpj', Servico.ItemServico.Items[I].DadosProfissionalParceiro.IdentificacaoParceiro.CpfCnpj);
        INIRec.WriteString(sSecao, 'InscricaoMunicipal', Servico.ItemServico.Items[I].DadosProfissionalParceiro.IdentificacaoParceiro.InscricaoMunicipal);
        INIRec.WriteString(sSecao, 'RazaoSocial', Servico.ItemServico.Items[I].DadosProfissionalParceiro.RazaoSocial);
        INIRec.WriteFloat(sSecao, 'PercentualProfissionalParceiro', Servico.ItemServico.Items[I].DadosProfissionalParceiro.PercentualProfissionalParceiro);

        // Provedor Infisc
        INIRec.WriteFloat(sSecao, 'totalAproxTribServ', Servico.ItemServico[I].totalAproxTribServ);
      end;

      //Padr�o Nacional
      if (Servico.comExt.tpMoeda <> 0) or (Servico.comExt.vServMoeda > 0) then
      begin
        sSecao := 'ComercioExterior';
        INIRec.WriteString(sSecao, 'mdPrestacao', mdPrestacaoToStr(Servico.comExt.mdPrestacao));
        INIRec.WriteString(sSecao, 'vincPrest', vincPrestToStr(Servico.comExt.vincPrest));
        INIRec.WriteInteger(sSecao, 'tpMoeda', Servico.comExt.tpMoeda);
        INIRec.WriteFloat(sSecao, 'vServMoeda', Servico.comExt.vServMoeda);
        INIRec.WriteString(sSecao, 'mecAFComexP', mecAFComexPToStr(Servico.comExt.mecAFComexP));
        INIRec.WriteString(sSecao, 'mecAFComexT', mecAFComexTToStr(Servico.comExt.mecAFComexT));
        INIRec.WriteString(sSecao, 'movTempBens', MovTempBensToStr(Servico.comExt.movTempBens));
        INIRec.WriteString(sSecao, 'nDI', Servico.comExt.nDI);
        INIRec.WriteString(sSecao, 'nRE', Servico.comExt.nRE);
        INIRec.WriteInteger(sSecao, 'mdic', Servico.comExt.mdic);
      end;

      //Padr�o Nacional
      if (Servico.Locacao.extensao <> '') or (Servico.Locacao.nPostes > 0)then
      begin
        sSecao := 'LocacaoSubLocacao';
        INIRec.WriteString(sSecao, 'categ', categToStr(Servico.Locacao.categ));
        INIRec.WriteString(sSecao, 'objeto', objetoToStr(Servico.Locacao.objeto));
        INIRec.WriteString(sSecao, 'extensao', Servico.Locacao.extensao);
        INIRec.WriteInteger(sSecao, 'nPostes', Servico.Locacao.nPostes);
      end;

      //Padr�o Nacional
      if (Servico.Evento.xNome <> '') or (Servico.Evento.dtIni > 0) or (Servico.Evento.dtFim > 0)then
      begin
        sSecao := 'Evento';
        INIRec.WriteString(sSecao, 'xNome', Servico.Evento.xNome);
        INIRec.WriteDate(sSecao, 'dtIni', Servico.Evento.dtIni);
        INIRec.WriteDate(sSecao, 'dtFim', Servico.Evento.dtFim);
        INIRec.WriteString(sSecao, 'idAtvEvt', Servico.Evento.idAtvEvt);
        INIRec.WriteString(sSecao, 'CEP', Servico.Evento.Endereco.CEP);
        INIRec.WriteString(sSecao, 'xMunicipio', Servico.Evento.Endereco.xMunicipio);
        INIRec.WriteString(sSecao, 'UF', Servico.Evento.Endereco.UF);
        INIRec.WriteString(sSecao, 'Logradouro', Servico.Evento.Endereco.Endereco);
        INIRec.WriteString(sSecao, 'Complemento', Servico.Evento.Endereco.Complemento);
        INIRec.WriteString(sSecao, 'Bairro', Servico.Evento.Endereco.Bairro);
      end;

      //Padr�o Nacional
      if (Servico.explRod.placa <> '') then
      begin
        sSecao := 'Rodoviaria';
        INIRec.WriteString(sSecao, 'categVeic', categVeicToStr(Servico.ExplRod.categVeic));
        INIRec.WriteInteger(sSecao, 'nEixos', Servico.ExplRod.nEixos);
        INIRec.WriteString(sSecao, 'rodagem', rodagemToStr(Servico.ExplRod.rodagem));
        INIRec.WriteString(sSecao, 'placa', Servico.ExplRod.placa);
        INIRec.WriteString(sSecao, 'sentido', Servico.ExplRod.sentido);
        INIRec.WriteString(sSecao, 'codAcessoPed', Servico.ExplRod.codAcessoPed);
        INIRec.WriteString(sSecao, 'codContrato', Servico.ExplRod.codContrato);
      end;

      if (Servico.infoCompl.idDocTec <> '') or (Servico.infoCompl.docRef <> '') or (Servico.infoCompl.xInfComp <> '') then
      begin
        sSecao := 'InformacoesComplementares';
        INIRec.WriteString(sSecao, 'idDocTec', Servico.infoCompl.idDocTec);
        INIRec.WriteString(sSecao, 'docRef', Servico.infoCompl.docRef);
        INIRec.WriteString(sSecao, 'xInfComp', Servico.infoCompl.xInfComp);
      end;

      sSecao:= 'Valores';
      INIRec.WriteFloat(sSecao, 'ValorServicos', Servico.Valores.ValorServicos);
      INIRec.WriteFloat(sSecao, 'ValorDeducoes', Servico.Valores.ValorDeducoes);
      INIRec.WriteFloat(sSecao, 'AliquotaDeducoes', Servico.Valores.AliquotaDeducoes);
      INIRec.WriteString(sSecao, 'JustificativaDeducao', Servico.Valores.JustificativaDeducao);
      INIRec.WriteFloat(sSecao, 'ValorPis', Servico.Valores.ValorPis);
      INIRec.WriteFloat(sSecao, 'AliquotaPis', Servico.Valores.AliquotaPis);
      INIRec.WriteString(sSecao, 'RetidoPis', FProvider.SimNaoToStr(Servico.Valores.RetidoPis));
      INIRec.WriteFloat(sSecao, 'ValorCofins', Servico.Valores.ValorCofins);
      INIRec.WriteFloat(sSecao, 'AliquotaCofins', Servico.Valores.AliquotaCofins);
      INIRec.WriteString(sSecao, 'RetidoCofins', FProvider.SimNaoToStr(Servico.Valores.RetidoCofins));
      INIRec.WriteFloat(sSecao, 'ValorInss', Servico.Valores.ValorInss);
      INIRec.WriteFloat(sSecao, 'AliquotaInss', Servico.Valores.AliquotaInss);
      INIRec.WriteString(sSecao, 'RetidoInss', FProvider.SimNaoToStr(Servico.Valores.RetidoInss));
      INIRec.WriteFloat(sSecao, 'ValorIr', Servico.Valores.ValorIr);
      INIRec.WriteFloat(sSecao, 'AliquotaIr', Servico.Valores.AliquotaIr);
      INIRec.WriteString(sSecao, 'RetidoIr', FProvider.SimNaoToStr(Servico.Valores.RetidoIr));
      INIRec.WriteFloat(sSecao, 'ValorCsll', Servico.Valores.ValorCsll);
      INIRec.WriteFloat(sSecao, 'AliquotaCsll', Servico.Valores.AliquotaCsll);
      INIRec.WriteString(sSecao, 'RetidoCsll', FProvider.SimNaoToStr(Servico.Valores.RetidoCsll));
      INIRec.WriteString(sSecao, 'ISSRetido', FProvider.SituacaoTributariaToStr(Servico.Valores.IssRetido));
      INIRec.WriteFloat(sSecao, 'AliquotaCpp', Servico.Valores.AliquotaCpp);
      INIRec.WriteFloat(sSecao, 'ValorCpp', Servico.Valores.ValorCpp);
      INIRec.WriteString(sSecao, 'RetidoCpp', FProvider.SimNaoToStr(Servico.Valores.RetidoCpp));
      INIRec.WriteFloat(sSecao, 'valorOutrasRetencoes', Servico.Valores.valorOutrasRetencoes);
      INIRec.WriteFloat(sSecao, 'OutrasRetencoes', Servico.Valores.OutrasRetencoes);
      INIRec.WriteString(sSecao, 'DescricaoOutrasRetencoes', Servico.Valores.DescricaoOutrasRetencoes);
      INIRec.WriteFloat(sSecao, 'DescontoIncondicionado', Servico.Valores.DescontoIncondicionado);
      INIRec.WriteFloat(sSecao, 'DescontoCondicionado', Servico.Valores.DescontoCondicionado);
      INIRec.WriteFloat(sSecao, 'OutrosDescontos', Servico.Valores.OutrosDescontos);
      INIRec.WriteFloat(sSecao, 'ValorRepasse', Servico.Valores.ValorRepasse);
      INIRec.WriteFloat(sSecao, 'BaseCalculo', Servico.Valores.BaseCalculo);
      INIRec.WriteFloat(sSecao, 'Aliquota', Servico.Valores.Aliquota);
      INIRec.WriteFloat(sSecao, 'AliquotaSN', Servico.Valores.AliquotaSN);
      INIRec.WriteFloat(sSecao, 'ValorIss', Servico.Valores.ValorIss);
      INIRec.WriteFloat(sSecao, 'ValorIssRetido', Servico.Valores.ValorIssRetido);
      INIRec.WriteFloat(sSecao, 'ValorLiquidoNfse', Servico.Valores.ValorLiquidoNfse);
      INIRec.WriteFloat(sSecao, 'ValorTotalNotaFiscal', Servico.Valores.ValorTotalNotaFiscal);
      INIRec.WriteFloat(sSecao, 'ValorTotalTributos', Servico.Valores.ValorTotalTributos);
      INIRec.WriteFloat(sSecao, 'ValorRecebido', Servico.Valores.ValorRecebido);
      INIRec.WriteFloat(sSecao, 'IrrfIndenizacao', Servico.Valores.IrrfIndenizacao);
      INIRec.WriteFloat(sSecao, 'RetencoesFederais', Servico.Valores.RetencoesFederais);

      // Provedor Infisc
      INIRec.WriteFloat(sSecao, 'totalAproxTrib', Servico.Valores.totalAproxTrib);

      sSecao := 'ValoresNFSe';
      INIRec.WriteFloat(sSecao, 'BaseCalculo', ValoresNfse.BaseCalculo);
      INIRec.WriteFloat(sSecao, 'Aliquota', ValoresNfse.Aliquota);
      INIRec.WriteFloat(sSecao, 'ValorLiquidoNfse', ValoresNfse.ValorLiquidoNfse);
      INIRec.WriteFloat(sSecao, 'ValorIss', ValoresNfse.ValorIss);

      //Padr�o Nacional
      for i := 0 to Servico.Valores.DocDeducao.Count - 1 do
      begin
        sSecao := 'DocumentosDeducoes' + IntToStrZero(i+1, 3);
        INIRec.WriteString(sSecao, 'chNFSe', Servico.Valores.DocDeducao[i].chNFSe);
        INIRec.WriteString(sSecao, 'chNFe', Servico.Valores.DocDeducao[i].chNFe);
        INIRec.WriteString(sSecao, 'nDoc', Servico.Valores.DocDeducao[i].nDoc);
        INIRec.WriteString(sSecao, 'tpDedRed', tpDedRedToStr(Servico.Valores.DocDeducao[i].tpDedRed));
        INIRec.WriteString(sSecao, 'xDescOutDed', Servico.Valores.DocDeducao[i].xDescOutDed);
        INIRec.WriteDate(sSecao, 'dtEmiDoc', Servico.Valores.DocDeducao[i].dtEmiDoc);
        INIRec.WriteFloat(sSecao, 'vDedutivelRedutivel', Servico.Valores.DocDeducao[i].vDedutivelRedutivel);
        INIRec.WriteFloat(sSecao, 'vDeducaoReducao', Servico.Valores.DocDeducao[i].vDeducaoReducao);
        INIRec.WriteString(sSecao, 'cMunNFSeMun', Servico.Valores.DocDeducao[i].NFSeMun.cMunNFSeMun);
        INIRec.WriteString(sSecao, 'nNFSeMun', Servico.Valores.DocDeducao[i].NFSeMun.nNFSeMun);
        INIRec.WriteString(sSecao, 'cVerifNFSeMun', Servico.Valores.DocDeducao[i].NFseMun.cVerifNFSeMun);
        INIRec.WriteString(sSecao, 'nNFS', Servico.Valores.DocDeducao[i].NFNFS.nNFS);
        INIRec.WriteString(sSecao, 'modNFS', Servico.Valores.DocDeducao[i].NFNFS.modNFS);
        INIRec.WriteString(sSecao, 'serieNFS', Servico.Valores.DocDeducao[i].NFNFS.serieNFS);

        if Servico.Valores.DocDeducao[i].fornec.Identificacao.CpfCnpj <> '' then
        begin
          sSecao := 'DocumentosDeducoesFornecedor' + IntToStrZero(i+1, 3);
          fornec := Servico.Valores.DocDeducao[i].fornec;

          INIRec.WriteString(sSecao, 'CNPJCPF', fornec.Identificacao.CpfCnpj);
          INIRec.WriteString(sSecao, 'InscricaoMunicipal', fornec.Identificacao.InscricaoMunicipal);
          INIRec.WriteString(sSecao, 'NIF', fornec.Identificacao.NIF);
          INIRec.WriteString(sSecao, 'cNaoNIF', NaoNIFToStr(fornec.Identificacao.cNaoNIF));
          INIRec.WriteString(sSecao, 'CAEEPF', fornec.Identificacao.CAEPF);

          INIRec.WriteString(sSecao, 'Logradouro', fornec.Endereco.Endereco);
          INIRec.WriteString(sSecao, 'Numero', fornec.Endereco.Numero);
          INIRec.WriteString(sSecao, 'Complemento', fornec.Endereco.Complemento);
          INIRec.WriteString(sSecao, 'Bairro', fornec.Endereco.Bairro);
          INIRec.WriteString(sSecao, 'CEP', fornec.Endereco.CEP);
          INIRec.WriteString(sSecao, 'xMunicipio', fornec.Endereco.xMunicipio);
          INIRec.WriteString(sSecao, 'UF', fornec.Endereco.UF);

          INIRec.WriteString(sSecao, 'Telefone', fornec.Contato.Telefone);
          INIRec.WriteString(sSecao, 'Email', fornec.Contato.Email);
        end;
      end;

      //Padr�o Nacional
      if (Servico.Valores.tribMun.pAliq > 0) or (Servico.Valores.tribMun.pRedBCBM > 0) or
         (Servico.Valores.tribMun.vRedBCBM > 0) or (Servico.Valores.tribMun.cPaisResult > 0) then
      begin
        sSecao := 'tribMun';
        INIRec.WriteString(sSecao, 'tribISSQN', tribISSQNToStr(Servico.Valores.tribMun.tribISSQN));
        INIRec.WriteInteger(sSecao, 'cPaisResult', Servico.Valores.tribMun.cPaisResult);
        INIRec.WriteString(sSecao, 'tpBM', tpBMToStr(Servico.Valores.tribMun.tpBM));
        INIRec.WriteString(sSecao, 'nBM', Servico.Valores.TribMun.nBM);
        INIRec.WriteFloat(sSecao, 'vRedBCBM', Servico.Valores.tribMun.vRedBCBM);
        INIRec.WriteFloat(sSecao, 'pRedBCBM', Servico.Valores.tribMun.pRedBCBM);
        INIRec.WriteString(sSecao, 'tpSusp', tpSuspToStr(Servico.Valores.tribMun.tpSusp));
        INIRec.WriteString(sSecao, 'nProcesso', Servico.Valores.tribMun.nProcesso);
        INIRec.WriteString(sSecao, 'tpImunidade', tpImunidadeToStr(Servico.Valores.tribMun.tpImunidade));
        INIRec.WriteFloat(sSecao, 'pAliq', Servico.Valores.tribMun.pAliq);
        INIRec.WriteString(sSecao, 'tpRetISSQN', tpRetISSQNToStr(Servico.Valores.tribMun.tpRetISSQN));
      end;

      //Padr�o Nacional
      if (Servico.Valores.tribFed.pAliqPis > 0) or (Servico.Valores.tribFed.pAliqCofins > 0) or
         (Servico.Valores.tribFed.vRetIRRF > 0) or (Servico.Valores.tribFed.vRetCP > 0) then
      begin
        sSecao := 'tribFederal';
        INIRec.WriteString(sSecao, 'CST', CSTToStr(Servico.Valores.tribFed.CST));
        INIRec.WriteFloat(sSecao, 'vBCPisCofins', Servico.Valores.tribFed.vBCPisCofins);
        INIRec.WriteFloat(sSecao, 'pAliqPis', Servico.Valores.tribFed.pAliqPis);
        INIRec.WriteFloat(sSecao, 'pAliqCofins', Servico.Valores.tribFed.pAliqCofins);
        INIRec.WriteFloat(sSecao, 'vPis', Servico.Valores.tribFed.vPis);
        INIRec.WriteFloat(sSecao, 'vCofins', Servico.Valores.tribFed.vCofins);
        INIRec.WriteString(sSecao, 'tpRetPisCofins', tpRetPisCofinsToStr(Servico.Valores.tribFed.tpRetPisCofins));
        INIRec.WriteFloat(sSecao, 'vRetCP', Servico.Valores.tribFed.vRetCP);
        INIRec.WriteFloat(sSecao, 'vRetIRRF', Servico.Valores.tribFed.vRetIRRF);
        INIRec.WriteFloat(sSecao, 'vRetCSLL', Servico.Valores.tribFed.vRetCSLL);
      end;

      sSecao := 'totTrib';
      INIRec.WriteString(sSecao, 'indTotTrib', indTotTribToStr(Servico.Valores.totTrib.indTotTrib));
      INIRec.WriteFloat(sSecao, 'pTotTribSN', Servico.Valores.totTrib.pTotTribSN);
      INIRec.WriteFloat(sSecao, 'vTotTribFed', Servico.Valores.totTrib.vTotTribFed);
      INIRec.WriteFloat(sSecao, 'vTotTribEst', Servico.Valores.totTrib.vTotTribEst);
      INIRec.WriteFloat(sSecao, 'vTotTribMun', Servico.Valores.totTrib.vTotTribMun);
      INIRec.WriteFloat(sSecao, 'pTotTribFed', Servico.Valores.totTrib.pTotTribFed);
      INIRec.WriteFloat(sSecao, 'pTotTribEst', Servico.Valores.totTrib.pTotTribEst);
      INIRec.WriteFloat(sSecao, 'pTotTribMun', Servico.Valores.totTrib.pTotTribMun);

      //Condi��o de Pagamento usado pelo provedor Betha vers�o 1 do Layout da ABRASF
      if CondicaoPagamento.QtdParcela > 0 then
      begin
        sSecao:= 'CondicaoPagamento';
        INIRec.WriteInteger(sSecao, 'QtdParcela', CondicaoPagamento.QtdParcela);
        INIRec.WriteString(sSecao, 'Condicao', FProvider.CondicaoPagToStr(CondicaoPagamento.Condicao));

        // Provedor NFEletronica
        if CondicaoPagamento.DataVencimento > 0 then
        begin
          INIRec.WriteDate(sSecao, 'DataVencimento', CondicaoPagamento.DataVencimento);
          INIRec.WriteString(sSecao, 'InstrucaoPagamento', CondicaoPagamento.InstrucaoPagamento);
          INIRec.WriteInteger(sSecao, 'CodigoVencimento', CondicaoPagamento.CodigoVencimento);
          if CondicaoPagamento.DataCriacao > 0 then
            INIRec.ReadDateTime(sSecao, 'DataCriacao', CondicaoPagamento.DataCriacao)
          else
            INIRec.ReadDateTime(sSecao, 'DataCriacao', Now);
        end;

        if Trim(OrgaoGerador.Uf) <> '' then
        begin
          sSecao := 'OrgaoGerador';
          INIRec.WriteString(sSecao, 'CodigoMunicipio', OrgaoGerador.CodigoMunicipio);
          INIRec.WriteString(sSecao, 'UF', OrgaoGerador.Uf);
        end;

        //Lista de parcelas, xx pode variar de 01-99 (provedor Betha vers�o 1 do Layout da ABRASF)
        for I := 0 to CondicaoPagamento.Parcelas.Count - 1 do
        begin
          sSecao:= 'Parcelas' + IntToStrZero(I + 1, 2);

          INIRec.WriteString(sSecao, 'Parcela', CondicaoPagamento.Parcelas.Items[I].Parcela);
          INIRec.WriteDate(sSecao, 'DataVencimento', CondicaoPagamento.Parcelas.Items[I].DataVencimento);
          INIRec.WriteFloat(sSecao, 'Valor', CondicaoPagamento.Parcelas.Items[I].Valor);
          INIRec.WriteString(sSecao, 'Condicao', FProvider.CondicaoPagToStr(CondicaoPagamento.Parcelas.Items[I].Condicao));

        end;
      end;
    end;
  finally
    IniNFSe := TStringList.Create;
    try
      INIRec.GetStrings(IniNFSe);
      INIRec.Free;

      Result := StringReplace(IniNFSe.Text, sLineBreak + sLineBreak, sLineBreak, [rfReplaceAll]);
    finally
      IniNFSe.Free;
    end;
  end;
end;

function TNotaFiscal.LerXML(const AXML: string): Boolean;
var
  FProvider: IACBrNFSeXProvider;
  TipoXml: TtpXML;
  XmlTratado: string;
begin
  FProvider := TACBrNFSeX(FACBrNFSe).Provider;

  if not Assigned(FProvider) then
    raise EACBrNFSeException.Create(ERR_SEM_PROVEDOR);

  Result := FProvider.LerXML(AXML, FNFSe, TipoXml, XmlTratado);

  if TipoXml = txmlNFSe then
    FXmlNfse := XmlTratado
  else
    if TipoXml = txmlEspelho then
      FXmlEspelho := XmlTratado
    else
      FXmlRps := XmlTratado;
end;

procedure TNotaFiscal.SetXmlNfse(const Value: string);
begin
  LerXML(Value);
  FXmlNfse := Value;
end;

function TNotaFiscal.GravarXML(const NomeArquivo: string;
  const PathArquivo: string; aTipo: TtpXML): Boolean;
var
  ConteudoEhXml: Boolean;
begin
  if EstaVazio(FXmlRps) then
    GerarXML;

  {
    Tem provedor que � gerando um JSON em vez de XML e o m�todo Gravar acaba
    incluindo na primeira linha do arquivo o encoding do XML.
    Para contornar isso a vari�vel ConteudoEhXml recebe o valor false quando �
    um JSON e o m�todo Gravar n�o inclui o encoding.
  }
  ConteudoEhXml := StringIsXML(FXmlRps);

  if aTipo = txmlNFSe then
  begin
    if EstaVazio(NomeArquivo) then
      FNomeArq := TACBrNFSeX(FACBrNFSe).GetNumID(NFSe) + '-nfse.xml'
    else
    begin
      FNomeArq := NomeArquivo;

      if ExtractFileExt(FNomeArq) = '' then
        FNomeArq := FNomeArq + '.xml';
    end;

    Result := TACBrNFSeX(FACBrNFSe).Gravar(FNomeArq, FXmlNfse, PathArquivo, ConteudoEhXml);
  end
  else
  begin
    FNomeArqRps := CalcularNomeArquivoCompleto(NomeArquivo, PathArquivo);
    Result := TACBrNFSeX(FACBrNFSe).Gravar(FNomeArqRps, FXmlRps, '', ConteudoEhXml);
  end;
end;

function TNotaFiscal.GravarStream(AStream: TStream): Boolean;
begin
  if EstaVazio(FXmlRps) then
    GerarXML;

  if EstaVazio(FXmlNfse) then
    FXmlNfse := FXmlRps;

  AStream.Size := 0;
  WriteStrToStream(AStream, AnsiString(FXmlNfse));
  Result := True;
end;

procedure TNotaFiscal.EnviarEmail(const sPara, sAssunto: string; sMensagem: TStrings;
  EnviaPDF: Boolean; sCC: TStrings; Anexos: TStrings; sReplyTo: TStrings;
  ManterPDFSalvo: Boolean);
var
  NomeArqTemp: string;
  AnexosEmail: TStrings;
  StreamNFSe: TMemoryStream;
begin
  if not Assigned(TACBrNFSeX(FACBrNFSe).MAIL) then
    raise EACBrNFSeException.Create('Componente ACBrMail n�o associado');

  AnexosEmail := TStringList.Create;
  StreamNFSe  := TMemoryStream.Create;
  try
    AnexosEmail.Clear;

    if Assigned(Anexos) then
      AnexosEmail.Assign(Anexos);

    with TACBrNFSeX(FACBrNFSe) do
    begin
      GravarStream(StreamNFSe);

      if (EnviaPDF) then
      begin
        if Assigned(DANFSE) then
        begin
          DANFSE.ImprimirDANFSEPDF(FNFSe);
          NomeArqTemp := DANFSE.ArquivoPDF;
          AnexosEmail.Add(NomeArqTemp);
        end;
      end;

      EnviarEmail( sPara, sAssunto, sMensagem, sCC, AnexosEmail, StreamNFSe,
                   NumID[FNFSe] +'-nfse.xml', sReplyTo);
    end;
  finally
    if not ManterPDFSalvo then
      DeleteFile(NomeArqTemp);

    AnexosEmail.Free;
    StreamNFSe.Free;
  end;
end;

function TNotaFiscal.GerarXML: string;
var
  FProvider: IACBrNFSeXProvider;
begin
  FProvider := TACBrNFSeX(FACBrNFSe).Provider;

  if not Assigned(FProvider) then
    raise EACBrNFSeException.Create(ERR_SEM_PROVEDOR);

  FProvider.GerarXml(NFSe, FXmlRps, FAlertas);
  Result := FXmlRps;
end;

function TNotaFiscal.GetXmlNfse: string;
begin
  Result := FXmlNfse;
  if Result = '' then
    Exit;

  if not XmlEhUTF8(Result) then
    Result := '<?xml version="1.0" encoding="UTF-8"?>' + Result;
end;

function TNotaFiscal.CalcularNomeArquivo: string;
var
  xID: string;
begin
  xID := TACBrNFSeX(FACBrNFSe).NumID[NFSe];

  if EstaVazio(xID) then
    raise EACBrNFSeException.Create('ID Inv�lido. Imposs�vel Salvar XML');

  Result := xID + '-rps.xml';
end;

function TNotaFiscal.CalcularPathArquivo: string;
var
  Data: TDateTime;
begin
  with TACBrNFSeX(FACBrNFSe) do
  begin
    if Configuracoes.Arquivos.EmissaoPathNFSe then
      Data := FNFSe.DataEmissaoRps
    else
      Data := Now;

    Result := PathWithDelim(Configuracoes.Arquivos.GetPathRPS(Data,
      FNFSe.Prestador.IdentificacaoPrestador.CpfCnpj,
      FNFSe.Prestador.IdentificacaoPrestador.InscricaoEstadual));
  end;
end;

function TNotaFiscal.CalcularNomeArquivoCompleto(NomeArquivo: string;
  PathArquivo: string): string;
begin
  if EstaVazio(NomeArquivo) then
    NomeArquivo := CalcularNomeArquivo;

  if EstaVazio(PathArquivo) then
    PathArquivo := CalcularPathArquivo
  else
    PathArquivo := PathWithDelim(PathArquivo);

  Result := PathArquivo + NomeArquivo;
end;

{ TNotasFiscais }

constructor TNotasFiscais.Create(AOwner: TACBrDFe);
begin
  if not (AOwner is TACBrNFSeX) then
    raise EACBrNFSeException.Create('AOwner deve ser do tipo TACBrNFSeX');

  inherited Create();

  FACBrNFSe := TACBrNFSeX(AOwner);
  FConfiguracoes := TACBrNFSeX(FACBrNFSe).Configuracoes;
end;

function TNotasFiscais.New: TNotaFiscal;
begin
  Result := TNotaFiscal.Create(FACBrNFSe);
  Add(Result);
end;

function TNotasFiscais.Add(ANota: TNotaFiscal): Integer;
begin
  Result := inherited Add(ANota);
end;

function TNotasFiscais.GerarIni: string;
begin
  Result := '';

  if (Self.Count > 0) then
    Result := Self.Items[0].GerarNFSeIni;
end;

procedure TNotasFiscais.GerarNFSe;
var
  i: integer;
begin
  for i := 0 to Self.Count - 1 do
    Self.Items[i].GerarXML;
end;

function TNotasFiscais.GetItem(Index: integer): TNotaFiscal;
begin
  Result := TNotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: string;
begin
  Result := 'NotaFiscal';
end;

procedure TNotasFiscais.VerificarDANFSE;
begin
  if not Assigned(TACBrNFSeX(FACBrNFSe).DANFSE) then
    raise EACBrNFSeException.Create('Componente DANFSE n�o associado.');
end;

procedure TNotasFiscais.Imprimir;
begin
  VerificarDANFSE;
  TACBrNFSeX(FACBrNFSe).DANFSE.ImprimirDANFSE(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  VerificarDANFSE;

  TACBrNFSeX(FACBrNFSe).DANFSE.ImprimirDANFSEPDF;
end;

procedure TNotasFiscais.ImprimirPDF(AStream: TStream);
begin
  VerificarDANFSE;

  TACBrNFSeX(FACBrNFSe).DANFSE.ImprimirDANFSEPDF(AStream);
end;

procedure TNotasFiscais.Insert(Index: Integer; ANota: TNotaFiscal);
begin
  inherited Insert(Index, ANota);
end;

function TNotasFiscais.FindByRps(const ANumRPS: string): TNotaFiscal;
var
  AItem: TNotaFiscal;
  AItemIndex: Integer;
begin
  Result := nil;

  if Self.Count = 0 then Exit;

  if not Self.fIsSorted then
  begin
  {$IfDef HAS_SYSTEM_GENERICS}
    Sort(TComparer<TObject>.Construct(CompRpsPorNumero));
  {$Else}
    Sort(@CompRpsPorNumero);
  {$EndIf}
  end;

  AItem := TNotaFiscal.Create(FACBrNFSe);
  try
    AItem.NFSe.IdentificacaoRps.Numero := ANumRPS;
    {$IfDef HAS_SYSTEM_GENERICS}
     AItemIndex := FindObject(AItem, TComparer<TObject>.Construct(CompRpsPorNumero));
    {$Else}
     AItemIndex := FindObject(Pointer(AItem), @CompRpsPorNumero);
    {$EndIf}
  finally
    AItem.Free;
  end;

  if AItemIndex = -1 then Exit;

  Result := Self.Items[AItemIndex];
end;

function TNotasFiscais.FindByNFSe(const ANumNFSe: string): TNotaFiscal;
var
  AItem: TNotaFiscal;
  AItemIndex: Integer;
begin
  Result := nil;

  if Self.Count = 0 then Exit;

  if not Self.fIsSorted then
  begin
  {$IfDef HAS_SYSTEM_GENERICS}
    Sort(TComparer<TObject>.Construct(CompNFSePorNumero));
  {$Else}
    Sort(@CompNFSePorNumero);
  {$EndIf}
  end;

  AItem := TNotaFiscal.Create(FACBrNFSe);
  try
    AItem.NFSe.Numero := ANumNFSe;
    {$IfDef HAS_SYSTEM_GENERICS}
     AItemIndex := FindObject(AItem, TComparer<TObject>.Construct(CompNFSePorNumero));
    {$Else}
     AItemIndex := FindObject(Pointer(AItem), @CompNFSePorNumero);
    {$EndIf}
  finally
    AItem.Free;
  end;

  if AItemIndex = -1 then Exit;

  Result := Self.Items[AItemIndex];
end;

function TNotasFiscais.FindByCnpjCpfSerieRps(const CnpjCpf, Serie,
  ANumRPS: string): TNotaFiscal;
var
  AItem: TNotaFiscal;
  AItemIndex: Integer;
begin
  Result := nil;

  if Self.Count = 0 then Exit;

  if not Self.fIsSorted then
  begin
  {$IfDef HAS_SYSTEM_GENERICS}
    Sort(TComparer<TObject>.Construct(CompRpsPorCnpjCpfSerieNumero));
  {$Else}
    Sort(@CompRpsPorCnpjCpfSerieNumero);
  {$EndIf}
  end;

  AItem := TNotaFiscal.Create(FACBrNFSe);
  try
    AItem.NFSe.IdentificacaoRps.Numero := ANumRPS;
    AItem.NFSe.IdentificacaoRps.Serie := Serie;
    AItem.NFSe.Prestador.IdentificacaoPrestador.CpfCnpj := CnpjCpf;

    {$IfDef HAS_SYSTEM_GENERICS}
     AItemIndex := FindObject(AItem, TComparer<TObject>.Construct(CompRpsPorCnpjCpfSerieNumero));
    {$Else}
     AItemIndex := FindObject(Pointer(AItem), @CompRpsPorCnpjCpfSerieNumero);
    {$EndIf}
  finally
    AItem.Free;
  end;

  if AItemIndex = -1 then Exit;

  Result := Self.Items[AItemIndex];
end;

procedure TNotasFiscais.SetItem(Index: integer; const Value: TNotaFiscal);
begin
  inherited Items[Index] := Value;
end;

function TNotasFiscais.LoadFromFile(const CaminhoArquivo: string;
  AGerarNFSe: Boolean = True): Boolean;
var
  XmlUTF8: AnsiString;
  i, l: integer;
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile(CaminhoArquivo);

    XmlUTF8 := ReadStrFromStream(MS, MS.Size);
  finally
    MS.Free;
  end;

  l := Self.Count; // Indice da �ltima nota j� existente

  Result := LoadFromString(XmlUTF8, AGerarNFSe);

  if Result then
  begin
    // Atribui Nome do arquivo a novas notas inseridas //
    for i := l to Self.Count - 1 do
    begin
      if Pos('-rps.xml', CaminhoArquivo) > 0 then
        Self.Items[i].NomeArqRps := CaminhoArquivo
      else
        Self.Items[i].NomeArq := CaminhoArquivo;
    end;
  end;
end;

function TNotasFiscais.LoadFromIni(const AIniString: string): Boolean;
begin
  with Self.New do
    LerArqIni(AIniString);

  Result := Self.Count > 0;
end;

function TNotasFiscais.LoadFromLoteNfse(const CaminhoArquivo: string): Boolean;
var
  XMLStr: string;
  XMLUTF8: AnsiString;
  i, l: integer;
  MS: TMemoryStream;
  P, N, TamTag, j: Integer;
  aXml, aXmlLote: string;
  TagF: Array[1..15] of string;
  SL: TStringStream;
  IsFile: Boolean;

  function PrimeiraNFSe: Integer;
  begin
    TagF[01] := '<CompNfse>';
    TagF[02] := '<ComplNfse>';
    TagF[03] := '<NFS-e>';
    TagF[04] := '<Nfse>';
    TagF[05] := '<nfse>';             // Provedor IPM
    TagF[06] := '<Nota>';
    TagF[07] := '<NFe>';
    TagF[08] := '<nfdok ';            // SmarAPD possui o atributo numeronfd
    TagF[09] := '<nfs>';
    TagF[10] := '<nfeRpsNotaFiscal>'; // Provedor EL
    TagF[11] := '<notasFiscais>';     // Provedor EL
    TagF[12] := '<notaFiscal>';       // Provedor GIAP
    TagF[13] := '<NOTA>';             // Provedor AssessorPublico
    TagF[14] := '<NOTA_FISCAL>';      // Provedor ISSDSF
    TagF[15] := '<tcCompNfse>';       // Provedor ISSCuritiba

    j := 0;

    repeat
      inc(j);
      TamTAG := Length(TagF[j]) -1;
      Result := Pos(TagF[j], aXmlLote);
    until (j = High(TagF)) or (Result <> 0);
  end;

  function PosNFSe: Integer;
  begin
    TagF[01] := '</CompNfse>';
    TagF[02] := '</ComplNfse>';
    TagF[03] := '</NFS-e>';
    TagF[04] := '</Nfse>';
    TagF[05] := '</nfse>';             // Provedor IPM
    TagF[06] := '</Nota>';
    TagF[07] := '</NFe>';
    TagF[08] := '</nfdok>';            // SmarAPD
    TagF[09] := '</nfs>';
    TagF[10] := '</nfeRpsNotaFiscal>'; // Provedor EL
    TagF[11] := '</notasFiscais>';     // Provedor EL
    TagF[12] := '</notaFiscal>';       // Provedor GIAP
    TagF[13] := '</NOTA>';             // Provedor AssessorPublico
    TagF[14] := '</NOTA_FISCAL>';      // Provedor ISSDSF
    TagF[15] := '</tcCompNfse>';       // Provedor ISSCuritiba

    j := 0;

    repeat
      inc(j);
      TamTAG := Length(TagF[j]) -1;
      Result := Pos(TagF[j], aXmlLote);
    until (j = High(TagF)) or (Result <> 0);
  end;

  function LimparXml(const XMLStr: string): string;
  begin
    Result := FaststringReplace(XMLStr, ' xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"', '', [rfReplaceAll]);
    Result := FaststringReplace(Result, ' xmlns:xsd="http://www.w3.org/2001/XMLSchema"', '', [rfReplaceAll]);
  end;
begin
  MS := TMemoryStream.Create;
  try
    IsFile := FilesExists(CaminhoArquivo);

    if (IsFile) then
      MS.LoadFromFile(CaminhoArquivo)
    else
    begin
      SL := TStringStream.Create(CaminhoArquivo);
      MS.LoadFromStream(SL);
      SL.Free;
    end;

    XMLUTF8 := ReadStrFromStream(MS, MS.Size);
  finally
    MS.Free;
  end;

  l := Self.Count; // Indice da �ltima nota j� existente

  XMLStr := LimparXml(XMLUTF8);

  aXmlLote := XMLStr;
  Result := False;
  P := PrimeiraNFSe;
  aXmlLote := copy(aXmlLote, P, length(aXmlLote));
  N := PosNFSe;

  while N > 0 do
  begin
    aXml := copy(aXmlLote, 1, N + TamTAG);
    aXmlLote := Trim(copy(aXmlLote, N + TamTAG + 1, length(aXmlLote)));

    Result := LoadFromString(aXml, False);

    N := PosNFSe;
  end;

  if Result then
  begin
    // Atribui Nome do arquivo a novas notas inseridas //
    for i := l to Self.Count - 1 do
    begin
      if Pos('-rps.xml', CaminhoArquivo) > 0 then
        Self.Items[i].NomeArqRps := CaminhoArquivo
      else
      begin
        if IsFile then
          Self.Items[i].NomeArq := CaminhoArquivo
        else
          Self.Items[i].NomeArq := TACBrNFSeX(FACBrNFSe).GetNumID(Items[i].NFSe) + '-nfse.xml';
      end;
    end;
  end;
end;

function TNotasFiscais.LoadFromStream(AStream: TStringStream;
  AGerarNFSe: Boolean = True): Boolean;
var
  AXML: AnsiString;
begin
  AStream.Position := 0;
  AXML := ReadStrFromStream(AStream, AStream.Size);

  Result := Self.LoadFromString(String(AXML), AGerarNFSe);
end;

function TNotasFiscais.LoadFromString(const AXMLString: string;
  AGerarNFSe: Boolean = True): Boolean;
begin
  with Self.New do
  begin
    LerXML(AXMLString);

    if AGerarNFSe then
      GerarXML;
  end;

  Result := Self.Count > 0;
end;

function TNotasFiscais.GravarXML(const PathNomeArquivo: string): Boolean;
var
  i: integer;
  NomeArq, PathArq : string;
begin
  Result := True;
  i := 0;

  while Result and (i < Self.Count) do
  begin
    PathArq := ExtractFilePath(PathNomeArquivo);
    NomeArq := ExtractFileName(PathNomeArquivo);
    Result := Self.Items[i].GravarXML(NomeArq, PathArq);
    Inc(i);
  end;
end;

end.
