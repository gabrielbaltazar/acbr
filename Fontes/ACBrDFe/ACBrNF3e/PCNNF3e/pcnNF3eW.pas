{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera??o com equipa- }
{ mentos de Automa??o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2020 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: Italo Jurisato Junior                           }
{                                                                              }
{  Voc? pode obter a ?ltima vers?o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca ? software livre; voc? pode redistribu?-la e/ou modific?-la }
{ sob os termos da Licen?a P?blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers?o 2.1 da Licen?a, ou (a seu crit?rio) }
{ qualquer vers?o posterior.                                                   }
{                                                                              }
{  Esta biblioteca ? distribu?da na expectativa de que seja ?til, por?m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl?cita de COMERCIABILIDADE OU      }
{ ADEQUA??O A UMA FINALIDADE ESPEC?FICA. Consulte a Licen?a P?blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN?A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc? deve ter recebido uma c?pia da Licen?a P?blica Geral Menor do GNU junto}
{ com esta biblioteca; se n?o, escreva para a Free Software Foundation, Inc.,  }
{ no endere?o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc? tamb?m pode obter uma copia da licen?a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim?es de Almeida - daniel@projetoacbr.com.br - www.projetoacbr.com.br}
{       Rua Coronel Aureliano de Camargo, 963 - Tatu? - SP - 18270-170         }
{******************************************************************************}

{$I ACBr.inc}

unit pcnNF3eW;

interface

uses
  SysUtils, Classes,
  pcnGerador, pcnNF3e, pcnConversao, pcnNF3eConsts;

type

  { TGeradorOpcoes }

  TGeradorOpcoes = class(TPersistent)
  private
    FGerarTagIPIparaNaoTributado: Boolean;
    FGerarTXTSimultaneamente: Boolean;
    FNormatizarMunicipios: Boolean;
    FGerarTagAssinatura: TpcnTagAssinatura;
    FPathArquivoMunicipios: String;
    FValidarInscricoes: Boolean;
    FValidarListaServicos: Boolean;
  published
    property GerarTagIPIparaNaoTributado: Boolean  read FGerarTagIPIparaNaoTributado;
    property GerarTXTSimultaneamente: Boolean      read FGerarTXTSimultaneamente write FGerarTXTSimultaneamente;
    property NormatizarMunicipios: Boolean         read FNormatizarMunicipios    write FNormatizarMunicipios;
    property GerarTagAssinatura: TpcnTagAssinatura read FGerarTagAssinatura      write FGerarTagAssinatura;
    property PathArquivoMunicipios: String         read FPathArquivoMunicipios   write FPathArquivoMunicipios;
    property ValidarInscricoes: Boolean            read FValidarInscricoes;
    property ValidarListaServicos: Boolean         read FValidarListaServicos;
  end;

  { TNF3eW }

  TNF3eW = class(TPersistent)
  private
    FGerador: TGerador;
    FNF3e: TNF3e;
    FOpcoes: TGeradorOpcoes;

    FVersao: String;
    FChaveNF3e: string;
    FIdCSRT: Integer;
    FCSRT: String;

    procedure GerarInfNF3e;
    procedure GerarIde;
    procedure GerarEmit;
    procedure GerarEnderEmit;
    procedure GerarDest;
    procedure GerarEnderDest(var UF: String);
    procedure GerarAcessante;
    procedure GerarSub;
    procedure GerarJudic;
    procedure GerarGrContrat;
    procedure GerarMed;
    procedure GerarSCEE;
    procedure GerarNFDet;
    procedure GerarDet(const i: Integer);
    procedure GerarDetItemAnt(const i, j: Integer);
    procedure GerarDetItem(const i, j: Integer);
    procedure GerargTarif(const i, j: Integer);
    procedure GerargAdBand(const i, j: Integer);
    procedure GerarDetProd(const i, j: Integer);
    procedure GerargMedicao(const i, j: Integer);
    procedure GerarImposto(const i, j: Integer);
    procedure GerarICMS(const i, j: Integer);
    procedure GerarPIS(const i, j: Integer);
    procedure GerarPISEfet(const i, j: Integer);
    procedure GerarCOFINS(const i, j: Integer);
    procedure GerarCOFINSEfet(const i, j: Integer);
    procedure GerarRetTrib(const i, j: Integer);
    procedure GerargProcRef(const i, j: Integer);
    procedure GerargProc(const i, j: Integer);
    procedure GerargContab(const i, j: Integer);
    procedure GerarTotal;
    procedure GerargFat;
    procedure GerarEnderCorresp;
    procedure GerargPIX;
    procedure GerargANEEL;
    procedure GerarautXML;
    procedure GerarInfAdic;
    procedure GerarinfRespTec;

    procedure AjustarMunicipioUF(out xUF: String; out xMun: String; out cMun: Integer;
      cPais: Integer; const vxUF, vxMun: String; vcMun: Integer);

  public
    constructor Create(AOwner: TNF3e);
    destructor Destroy; override;

    function GerarXml: Boolean;
    function ObterNomeArquivo: String;
  published
    property Gerador: TGerador      read FGerador write FGerador;
    property NF3e: TNF3e            read FNF3e    write FNF3e;
    property Opcoes: TGeradorOpcoes read FOpcoes  write FOpcoes;
    property IdCSRT: Integer        read FIdCSRT  write FIdCSRT;
    property CSRT: String           read FCSRT    write FCSRT;
  end;

implementation

uses
  pcnConversaoNF3e, pcnAuxiliar,
  ACBrDFeUtil, pcnConsts, ACBrUtil;

{ TNF3eW }

constructor TNF3eW.Create(AOwner: TNF3e);
begin
  inherited Create;

  FNF3e    := AOwner;
  FGerador := TGerador.Create;

  FGerador.FIgnorarTagNivel   := '|?xml version|NF3e xmlns|infNF3e versao|obsCont|obsFisco|';
  FGerador.Opcoes.QuebraLinha := ';';

  FOpcoes := TGeradorOpcoes.Create;

  FOpcoes.FGerarTXTSimultaneamente     := False;
  FOpcoes.FGerarTagIPIparaNaoTributado := True;
  FOpcoes.FNormatizarMunicipios        := False;
  FOpcoes.FPathArquivoMunicipios       := '';
  FOpcoes.FGerarTagAssinatura          := taSomenteSeAssinada;
  FOpcoes.FValidarInscricoes           := False;
  FOpcoes.FValidarListaServicos        := False;
end;

destructor TNF3eW.Destroy;
begin
  FGerador.Free;
  FOpcoes.Free;

  inherited Destroy;
end;

function TNF3eW.ObterNomeArquivo: String;
begin
  Result := OnlyNumber(NF3e.infNF3e.ID) + '-NF3e.xml';
end;

function TNF3eW.GerarXml: Boolean;
var
  Gerar: Boolean;
  xProtNF3e : String;
  xCNPJCPF : string;
begin
  Gerador.ListaDeAlertas.Clear;

  FVersao  := Copy(NF3e.infNF3e.VersaoStr, 9, 4);
  xCNPJCPF := NF3e.emit.CNPJ;

  FChaveNF3e := GerarChaveAcesso(NF3e.ide.cUF, NF3e.ide.dhEmi, xCNPJCPF, NF3e.ide.serie,
                            NF3e.ide.nNF, StrToInt(TpEmisToStr(NF3e.ide.tpEmis)),
                            NF3e.ide.cNF, NF3e.ide.modelo);

  NF3e.infNF3e.ID := 'NF3e' + FChaveNF3e;

  NF3e.ide.cDV := ExtrairDigitoChaveAcesso(NF3e.infNF3e.ID);
  NF3e.Ide.cNF := ExtrairCodigoChaveAcesso(NF3e.infNF3e.ID);

  Gerador.LayoutArquivoTXT.Clear;
  Gerador.ArquivoFormatoXML := '';
  Gerador.ArquivoFormatoTXT := '';

  {$IfDef FPC}
   Gerador.wGrupo(ENCODING_UTF8, '', False);
  {$EndIf}

  if NF3e.procNF3e.nProt <> '' then
    Gerador.wGrupo('nf3eProc ' + NF3e.infNF3e.VersaoStr + ' ' + NAME_SPACE_NF3e, '');

  Gerador.wGrupo('NF3e ' + NAME_SPACE_NF3e);
  Gerador.wGrupo('infNF3e ' + NF3e.infNF3e.VersaoStr + ' Id="NF3e' + NF3e.infNF3e.ID + '"');

  GerarInfNF3e;

  Gerador.wGrupo('/infNF3e');

  if NF3e.infNF3eSupl.qrCodNF3e <> '' then
  begin
    Gerador.wGrupo('infNF3eSupl', '#289');
    Gerador.wCampo(tcStr, '#290', 'qrCodNF3e', 50, 1000, 1,
                     '<![CDATA[' + NF3e.infNF3eSupl.qrCodNF3e + ']]>', DSC_INFQRCODE,False);
    Gerador.wGrupo('/infNF3eSupl');
  end;

  if FOpcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := true;
    if FOpcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((NF3e.signature.DigestValue <> '') and (NF3e.signature.SignatureValue <> '') and (NF3e.signature.X509Certificate <> ''));

    if FOpcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
      Gerar := ((NF3e.signature.DigestValue = '') and (NF3e.signature.SignatureValue = '') and (NF3e.signature.X509Certificate = ''));

    if Gerar then
    begin
      FNF3e.signature.URI := '#NF3e' + NF3e.infNF3e.ID;
      FNF3e.signature.Gerador.Opcoes.IdentarXML := Gerador.Opcoes.IdentarXML;
      FNF3e.signature.GerarXML;
      Gerador.ArquivoFormatoXML := Gerador.ArquivoFormatoXML + FNF3e.signature.Gerador.ArquivoFormatoXML;
    end;
  end;

  Gerador.wGrupo('/NF3e');

  if NF3e.procNF3e.nProt <> '' then
   begin
     xProtNF3e :=
       (**)'<protNF3e ' + NF3e.infNF3e.VersaoStr + '>' +
     (******)'<infProt>'+
     (*********)'<tpAmb>'+TpAmbToStr(NF3e.procNF3e.tpAmb)+'</tpAmb>'+
     (*********)'<verAplic>'+NF3e.procNF3e.verAplic+'</verAplic>'+
     (*********)'<chNF3e>'+NF3e.procNF3e.chNF3e+'</chNF3e>'+
     (*********)'<dhRecbto>'+FormatDateTime('yyyy-mm-dd"T"hh:nn:ss',NF3e.procNF3e.dhRecbto) +
                             GetUTC(CodigoParaUF(FNF3e.Ide.cUF), NF3e.procNF3e.dhRecbto)+'</dhRecbto>'+
     (*********)'<nProt>'+NF3e.procNF3e.nProt+'</nProt>'+
     (*********)'<digVal>'+NF3e.procNF3e.digVal+'</digVal>'+
     (*********)'<cStat>'+IntToStr(NF3e.procNF3e.cStat)+'</cStat>'+
     (*********)'<xMotivo>'+NF3e.procNF3e.xMotivo+'</xMotivo>'+
                IIF( (NF3e.procNF3e.cMsg > 0) or (NF3e.procNF3e.xMsg <> ''),
         (*********)'<infFisco><cMsg>'+IntToStr(NF3e.procNF3e.cMsg)+'</cMsg>'+
         (*********)'<xMsg>'+NF3e.procNF3e.xMsg+'</xMsg></infFisco>',
                    '') +
     (******)'</infProt>'+
     (****)'</protNF3e>';

     (**)Gerador.wTexto(xProtNF3e);
     Gerador.wGrupo('/nf3eProc');
   end;

  Gerador.gtAjustarRegistros(NF3e.infNF3e.ID);
  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

procedure TNF3eW.GerarInfNF3e;
begin
  GerarIde;
  GerarEmit;
  GerarDest;
  GerarAcessante;
  GerarSub;
  GerarJudic;
  GerarGrContrat;
  GerarMed;
  GerarSCEE;
  GerarNFDet;
  GerarTotal;
  GerargFat;

  if NF3e.gPIX.urlQRCodePIX <> '' then
    GerargPIX;

  GerargANEEL;
  GerarautXML;
  GerarInfAdic;
  GerarinfRespTec;
end;

procedure TNF3eW.GerarIde;
begin
  Gerador.wGrupo('ide', '#004');
  Gerador.wCampo(tcInt, '#005', 'cUF', 2, 2, 1, NF3e.ide.cUF, DSC_CUF);

  if not ValidarCodigoUF(NF3e.ide.cUF) then
    Gerador.wAlerta('#005', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#006', 'tpAmb ', 01, 01, 1, tpAmbToStr(NF3e.Ide.tpAmb), DSC_TPAMB);
  Gerador.wCampo(tcInt, '#007', 'mod   ', 02, 02, 1, NF3e.ide.modelo, DSC_MOD);
  Gerador.wCampo(tcInt, '#008', 'serie ', 01, 03, 1, NF3e.ide.serie, DSC_SERIE);
  Gerador.wCampo(tcInt, '#009', 'nNF   ', 01, 09, 1, NF3e.ide.nNF, DSC_NNF);
  Gerador.wCampo(tcStr, '#010', 'cNF   ', 08, 08, 1, IntToStrZero(ExtrairCodigoChaveAcesso(NF3e.infNF3e.ID), 8), DSC_CNF);
  Gerador.wCampo(tcInt, '#011', 'cDV   ', 01, 01, 1, NF3e.Ide.cDV, DSC_CDV);
  Gerador.wCampo(tcStr, '#012', 'dhEmi ', 25, 25, 1, DateTimeTodh(NF3e.ide.dhEmi) +
                    GetUTC(CodigoParaUF(NF3e.ide.cUF), NF3e.ide.dhEmi), DSC_DEMI);
  Gerador.wCampo(tcStr, '#013', 'tpEmis', 01, 01, 1, tpEmisToStr(NF3e.Ide.tpEmis), DSC_TPEMIS);
  Gerador.wCampo(tcInt, '#014', 'cMunFG', 07, 07, 1, NF3e.ide.cMunFG, DSC_CMUNFG);

  if not ValidarMunicipio(NF3e.ide.cMunFG) then
    Gerador.wAlerta('#014', 'cMunFG', DSC_CMUNFG, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#015', 'finNF3e', 1, 01, 1, finNF3eToStr(NF3e.Ide.finNF3e), DSC_FINNF3e);
  Gerador.wCampo(tcStr, '#016', 'verProc', 1, 20, 1, NF3e.Ide.verProc, DSC_VERPROC);

  if (NF3e.Ide.dhCont > 0) or (NF3e.Ide.xJust <> '') then
  begin
    Gerador.wCampo(tcStr, '#017', 'dhCont', 25, 025, 1, DateTimeTodh(NF3e.ide.dhCont) +
                GetUTC(CodigoParaUF(NF3e.ide.cUF), NF3e.ide.dhCont), DSC_DHCONT);
    Gerador.wCampo(tcStr, '#018', 'xJust ', 01, 256, 1, NF3e.ide.xJust, DSC_XJUSTCONT);
  end;

  Gerador.wGrupo('/ide');
end;

procedure TNF3eW.GerarEmit;
begin
  Gerador.wGrupo('emit', '#019');
  Gerador.wCampoCNPJCPF('#020', '#020', NF3e.Emit.CNPJ);

  if NF3e.Emit.IE = 'ISENTO' then
    Gerador.wCampo(tcStr, '#021', 'IE', 0, 14, 1, NF3e.Emit.IE, DSC_IE)
  else
    Gerador.wCampo(tcStr, '#021', 'IE', 0, 14, 1, OnlyNumber(NF3e.Emit.IE), DSC_IE);

  if (FOpcoes.ValidarInscricoes) then
  begin
    if Length(NF3e.Emit.IE) = 0 then
      Gerador.wAlerta('#021', 'IE', DSC_IE, ERR_MSG_VAZIO)
    else
    begin
      if not pcnAuxiliar.ValidarIE(NF3e.Emit.IE, CodigoParaUF(NF3e.Ide.cUF)) then
        Gerador.wAlerta('#021', 'IE', DSC_IE, ERR_MSG_INVALIDO);
    end;
  end;

  Gerador.wCampo(tcStr, '#022', 'xNome', 2, 60, 1, NF3e.Emit.xNome, DSC_XNOME);
  Gerador.wCampo(tcStr, '#023', 'xFant', 1, 60, 0, NF3e.Emit.xFant, DSC_XFANT);

  GerarEnderEmit;

  Gerador.wGrupo('/emit');
end;

procedure TNF3eW.GerarEnderEmit;
var
  cMun: Integer;
  xMun: String;
  xUF: String;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL, NF3e.Emit.enderEmit.UF, NF3e.Emit.enderEmit.xMun, NF3e.Emit.EnderEmit.cMun);

  Gerador.wGrupo('enderEmit', '#024');
  Gerador.wCampo(tcStr, '#025', 'xLgr   ', 2, 60, 1, NF3e.Emit.enderEmit.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#026', 'nro    ', 1, 60, 1, NF3e.Emit.enderEmit.nro, DSC_NRO);
  Gerador.wCampo(tcStr, '#027', 'xCpl   ', 1, 60, 0, NF3e.Emit.enderEmit.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#028', 'xBairro', 2, 60, 1, NF3e.Emit.enderEmit.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#029', 'cMun   ', 1, 07, 1, cMun, DSC_CMUN);

  if not ValidarMunicipio(cMun) then
    Gerador.wAlerta('#029', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#030', 'xMun', 2, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#031', 'CEP ', 8, 08, 1, NF3e.Emit.enderEmit.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#032', 'UF  ', 2, 02, 1, xUF, DSC_UF);

  if not pcnAuxiliar.ValidarUF(xUF) then
    Gerador.wAlerta('#032', 'UF', DSC_UF, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#033', 'fone ', 6, 14, 0, OnlyNumber(NF3e.Emit.enderEmit.fone), DSC_FONE);
  Gerador.wCampo(tcStr, '#034', 'email', 1, 60, 0, NF3e.Emit.enderEmit.email, DSC_XPAIS);
  Gerador.wGrupo('/enderEmit');
end;

procedure TNF3eW.GerarDest;
var
  UF: String;
const
  HOM_NOME_DEST = 'NF3-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL';
begin
  UF := '';
  Gerador.wGrupo('dest', '#035');

  if NF3e.Ide.tpAmb = taProducao then
    Gerador.wCampo(tcStr, '#036', 'xNome', 2, 60, 1, NF3e.Dest.xNome, DSC_XNOME)
  else
    Gerador.wCampo(tcStr, '#036', 'xNome', 2, 60, 1, HOM_NOME_DEST, DSC_XNOME);

  if (NF3e.Dest.idOutros <> '') then
    Gerador.wCampo(tcStr, '#039', 'idOutros', 2, 20, 1, NF3e.Dest.idOutros, DSC_IDESTR)
  else
    Gerador.wCampoCNPJCPF('#037', '#038', NF3e.Dest.CNPJCPF, True);

  Gerador.wCampo(tcStr, '#040', 'indIEDest', 1, 01, 1, indIEDestToStr(NF3e.Dest.indIEDest), DSC_INDIEDEST);

  if NF3e.Dest.indIEDest <> inIsento then
  begin
    if (NF3e.Dest.IE <> '') or (NF3e.infNF3e.Versao < 3) then
     begin
       // Inscri??o Estadual
       if NF3e.Dest.IE = '' then
         Gerador.wCampo(tcStr, '#041', 'IE', 0, 14, 1, '', DSC_IE)
       else
       if NF3e.Dest.IE = 'ISENTO' then
         Gerador.wCampo(tcStr, '#041', 'IE', 0, 14, 1, NF3e.Dest.IE, DSC_IE)
       else
       if (trim(NF3e.Dest.IE) <> '') or (NF3e.Ide.modelo <> 65)  then
         Gerador.wCampo(tcStr, '#041', 'IE', 0, 14, 1, OnlyNumber(NF3e.Dest.IE), DSC_IE);

       if (FOpcoes.ValidarInscricoes) and (NF3e.Dest.IE <> '') and (NF3e.Dest.IE <> 'ISENTO') then
         if not pcnAuxiliar.ValidarIE(NF3e.Dest.IE, UF) then
           Gerador.wAlerta('#041', 'IE', DSC_IE, ERR_MSG_INVALIDO);
     end;
  end;

  Gerador.wCampo(tcStr, '#042', 'IM', 1, 15, 0, NF3e.Dest.IM, DSC_IM);

  if NF3e.Dest.cNIS <> '' then
    Gerador.wCampo(tcStr, '#043', 'cNIS', 1, 15, 0, NF3e.Dest.cNIS, DSC_CNIS)
  else
    Gerador.wCampo(tcStr, '#043', 'NB', 1, 10, 0, NF3e.Dest.NB, DSC_NB);

  Gerador.wCampo(tcStr, '#044', 'xNomeAdicional', 2, 60, 0, NF3e.Dest.xNomeAdicional, DSC_XNOME);

  GerarEnderDest(UF);

  Gerador.wGrupo('/dest');
end;

procedure TNF3eW.GerarEnderDest(var UF: String);
var
  cMun: Integer;
  xMun: String;
  xUF: String;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, 1058, NF3e.Dest.enderDest.UF, NF3e.Dest.enderDest.xMun, NF3e.Dest.enderDest.cMun);

  UF := xUF;
  Gerador.wGrupo('enderDest', '#045');
  Gerador.wCampo(tcStr, '#046', 'xLgr   ', 2, 60, 1, NF3e.Dest.enderDest.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#047', 'nro    ', 1, 60, 1, NF3e.Dest.enderDest.nro, DSC_NRO);
  Gerador.wCampo(tcStr, '#048', 'xCpl   ', 1, 60, 0, NF3e.Dest.enderDest.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#049', 'xBairro', 1, 60, 1, NF3e.Dest.enderDest.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#050', 'cMun   ', 1, 07, 1, cMun, DSC_CMUN);

  if not ValidarMunicipio(cMun) then
    Gerador.wAlerta('#050', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#051', 'xMun', 2, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#052', 'CEP ', 8, 08, 0, NF3e.Dest.enderDest.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#053', 'UF  ', 2, 02, 1, xUF, DSC_UF);

  if not pcnAuxiliar.ValidarUF(xUF) then
    Gerador.wAlerta('#053', 'UF', DSC_UF, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#054', 'fone ', 6, 14, 0, OnlyNumber(NF3e.Dest.enderDest.fone), DSC_FONE);
  Gerador.wCampo(tcStr, '#055', 'email', 1, 60, 0, NF3e.Dest.enderDest.email, DSC_XPAIS);
  Gerador.wGrupo('/enderDest');
end;

procedure TNF3eW.GerarAcessante;
begin
  Gerador.wGrupo('acessante', '#056');
  Gerador.wCampo(tcStr, '#057', 'idAcesso    ', 01, 15, 1, NF3e.acessante.idAcesso, DSC_IDACESSO);
  Gerador.wCampo(tcStr, '#058', 'idCodCliente', 05, 20, 0, NF3e.acessante.idCodCliente, DSC_IDCODCLIENTE);
  Gerador.wCampo(tcStr, '#059', 'tpAcesso    ', 01, 01, 1, tpAcessoToStr(NF3e.acessante.tpAcesso), DSC_TPACESSO);
  Gerador.wCampo(tcStr, '#060', 'xNomeUC     ', 02, 60, 0, NF3e.acessante.xNomeUC, DSC_XNOMEUC);
  Gerador.wCampo(tcStr, '#061', 'tpClasse    ', 02, 02, 0, tpClasseToStr(NF3e.acessante.tpClasse), DSC_TPCLASSE);
  Gerador.wCampo(tcStr, '#062', 'tpSubClasse ', 02, 02, 0, tpSubClasseToStr(NF3e.acessante.tpSubClasse), DSC_TPSUBCLASSE);
  Gerador.wCampo(tcStr, '#063', 'tpFase      ', 01, 01, 1, tpFaseToStr(NF3e.acessante.tpFase), DSC_TPFASE);
  Gerador.wCampo(tcStr, '#064', 'tpGrpTensao ', 02, 02, 1, tpGrpTensaoToStr(NF3e.acessante.tpGrpTensao), DSC_TPGRPTENSAO);
  Gerador.wCampo(tcStr, '#065', 'tpModTar    ', 02, 02, 1, tpModTarToStr(NF3e.acessante.tpModTar), DSC_TPMODTAR);

  Gerador.wCampo(tcStr, '#066', 'latGPS ', 2, 6, 1, NF3e.acessante.latGPS, DSC_LATGPS);
  Gerador.wCampo(tcStr, '#067', 'longGPS', 2, 6, 1, NF3e.acessante.longGPS, DSC_LONGGPS);

  Gerador.wCampo(tcStr, '#068', 'codRoteiroLeitura', 1, 100, 0, NF3e.acessante.codRoteiroLeitura, DSC_CODROTEIROLEITURA);

  Gerador.wGrupo('/acessante');
end;

procedure TNF3eW.GerarSub;
begin
  if (NF3e.gSub.chNF3e <> '') or (NF3e.gSub.CNPJ <> '') then
  begin
    Gerador.wGrupo('gSub', '#069');

    if NF3e.gSub.chNF3e <> '' then
    begin
      Gerador.wCampo(tcStr, '#070', 'chNF3e', 44, 44, 1, NF3e.gSub.chNF3e, DSC_CHNF3E);

      if not ValidarChave(NF3e.gSub.chNF3e) then
        Gerador.wAlerta('#070', 'chNF3e', DSC_CHNF3E, ERR_MSG_INVALIDO);
    end
    else
    begin
      Gerador.wGrupo('gNF', '#071');
      Gerador.wCampo(tcStr, '#072', 'CNPJ      ', 14, 14, 1, NF3e.gSub.CNPJ, DSC_CNPJ);
      Gerador.wCampo(tcStr, '#073', 'serie     ', 03, 03, 1, NF3e.gSub.serie, DSC_SERIE);
      Gerador.wCampo(tcInt, '#074', 'nNF       ', 01, 09, 1, NF3e.gSub.nNF, DSC_NNF);
      Gerador.wCampo(tcStr, '#075', 'CompetEmis', 06, 06, 1, FormatDateTime('yyyymm', NF3e.gSub.CompetEmis), DSC_COMPETEMIS);
      Gerador.wCampo(tcStr, '#076', 'CompetApur', 06, 06, 1, FormatDateTime('yyyymm', NF3e.gSub.CompetApur), DSC_COMPETAPUR);
      Gerador.wCampo(tcStr, '#077', 'hash115   ', 28, 28, 0, NF3e.gSub.hash115, DSC_HASH115);
      Gerador.wGrupo('/gNF');
    end;

    Gerador.wCampo(tcStr, '#078', 'motSub', 2, 2, 1, motSubToStr(NF3e.gSub.motSub), DSC_MOTSUB);

    Gerador.wGrupo('/gSub');
  end;
end;

procedure TNF3eW.GerarJudic;
begin
  if (NF3e.gJudic.chNF3e <> '') then
  begin
    Gerador.wGrupo('gJudic', '#079');

    Gerador.wCampo(tcStr, '#080', 'chNF3e', 44, 44, 1, NF3e.gJudic.chNF3e, DSC_CHNF3E);
    Gerador.wCampo(tcStr, '#081', 'motSub', 02, 02, 1, motSubToStr(NF3e.gSub.motSub), DSC_MOTSUB);

    if not ValidarChave(NF3e.gJudic.chNF3e) then
      Gerador.wAlerta('#080', 'chNF3e', DSC_CHNF3E, ERR_MSG_INVALIDO);

    Gerador.wGrupo('/gJudic');
  end;
end;

procedure TNF3eW.GerarGrContrat;
var
  i: Integer;
begin
  for i := 0 to NF3e.gGrContrat.Count - 1 do
  begin
    Gerador.wGrupo('gGrContrat nContrat="' +
                  FormatFloat('00', NF3e.gGrContrat[i].nContrat) + '"', '#081');

    if (NF3e.gGrContrat[i].nContrat > 20) then
      Gerador.wAlerta('#082', 'nContrat', DSC_NCONTRAT, ERR_MSG_MAIOR);

    if (NF3e.gGrContrat[i].nContrat < 1) then
      Gerador.wAlerta('#082', 'nContrat', DSC_NCONTRAT, ERR_MSG_MENOR);

    Gerador.wCampo(tcStr, '#083', 'tpGrContrat ', 1, 01, 1, tpGrContratToStr(NF3e.gGrContrat[i].tpGrContrat), DSC_TPGRCONTRAT);
    Gerador.wCampo(tcStr, '#084', 'tpPosTar    ', 1, 01, 1, tpPosTarToStr(NF3e.gGrContrat[i].tpPosTar), DSC_TPPOSTAR);
    Gerador.wCampo(tcDe2, '#085', 'qUnidContrat', 1, 15, 0, NF3e.gGrContrat[i].qUnidContrat, DSC_QUNIDCONTRAT);

    Gerador.wGrupo('/gGrContrat');
  end;

  if NF3e.gGrContrat.Count > 20 then
    Gerador.wAlerta('#081', 'gGrContrat', '', ERR_MSG_MAIOR_MAXIMO + '20');
end;

procedure TNF3eW.GerarMed;
var
  i: Integer;
begin
  for i := 0 to NF3e.gMed.Count - 1 do
  begin
    Gerador.wGrupo('gMed nMed="' +
                            FormatFloat('00', NF3e.gMed[i].nMed) + '"', '#086');

    if (NF3e.gMed[i].nMed > 20) then
      Gerador.wAlerta('#087', 'nMed', DSC_NMED, ERR_MSG_MAIOR);

    if (NF3e.gMed[i].nMed < 1) then
      Gerador.wAlerta('#087', 'nMed', DSC_NMED, ERR_MSG_MENOR);

    Gerador.wCampo(tcInt, '#088', 'idMedidor', 01, 15, 1, NF3e.gMed[i].idMedidor, DSC_IDMEDIDOR);
    Gerador.wCampo(tcDat, '#089', 'dMedAnt  ', 10, 10, 1, NF3e.gMed[i].dMedAnt, DSC_DMEDANT);
    Gerador.wCampo(tcDat, '#090', 'dMedAtu  ', 10, 10, 1, NF3e.gMed[i].dMedAnt, DSC_DMEDATU);

    Gerador.wGrupo('/gMed');
  end;

  if NF3e.gMed.Count > 20 then
    Gerador.wAlerta('#086', 'gMed', '', ERR_MSG_MAIOR_MAXIMO + '20');
end;

procedure TNF3eW.GerarSCEE;
var
  i: Integer;
begin
  if (NF3e.gSCEE.gSaldoCred.Count > 0) then
  begin
    Gerador.wGrupo('gSCEE', '#091');

    Gerador.wCampo(tcStr, '#092', 'tpPartComp', 1, 1, 1, tpPartCompToStr(NF3e.gSCEE.tpPartComp), DSC_TPPARTCOMP);

    for i := 0 to NF3e.gSCEE.gConsumidor.Count - 1 do
    begin
      Gerador.wGrupo('gConsumidor', '#093');
      Gerador.wCampo(tcInt, '#094', 'idAcessGer', 1, 15, 1, NF3e.gSCEE.gConsumidor[i].idAcessGer, DSC_IDACESSGER);
      Gerador.wCampo(tcDe3, '#095', 'vPotInst  ', 1, 09, 1, NF3e.gSCEE.gConsumidor[i].vPotInst, DSC_VPOTINST);
      Gerador.wCampo(tcStr, '#096', 'tpFonteEnergia', 1, 01, 1, tpFonteEnergiaToStr(NF3e.gSCEE.gConsumidor[i].tpFonteEnergia), DSC_TPFONTEENERGIA);
      Gerador.wCampo(tcDe3, '#097', 'enerAloc  ', 1, 08, 1, NF3e.gSCEE.gConsumidor[i].enerAloc, DSC_ENERALOC);
      Gerador.wCampo(tcStr, '#098', 'tpPosTar  ', 1, 01, 1, tpPosTarToStr(NF3e.gSCEE.gConsumidor[i].tpPosTar), DSC_TPPOSTAR);
      Gerador.wGrupo('/gConsumidor');
    end;

    if NF3e.gSCEE.gConsumidor.Count > 999 then
      Gerador.wAlerta('#094', 'gConsumidor', '', ERR_MSG_MAIOR_MAXIMO + '999');

    for i := 0 to NF3e.gSCEE.gSaldoCred.Count - 1 do
    begin
      Gerador.wGrupo('gSaldoCred', '#098');
      Gerador.wCampo(tcStr, '#099', 'tpPosTar', 1, 01, 1, tpPosTarToStr(NF3e.gSCEE.gSaldoCred[i].tpPosTar), DSC_TPPOSTAR);

      if Frac(NF3e.gSCEE.gSaldoCred[i].vSaldAnt) > 0 then
        Gerador.wCampo(tcDe4, '#100', 'vSaldAnt', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vSaldAnt, DSC_VSALDANT)
      else
        Gerador.wCampo(tcInt, '#100', 'vSaldAnt', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vSaldAnt, DSC_VSALDANT);

      if Frac(NF3e.gSCEE.gSaldoCred[i].vCredExpirado) > 0 then
        Gerador.wCampo(tcDe4, '#101', 'vCredExpirado', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vCredExpirado, DSC_VCREDEXPIRADO)
      else
        Gerador.wCampo(tcInt, '#101', 'vCredExpirado', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vCredExpirado, DSC_VCREDEXPIRADO);

      if Frac(NF3e.gSCEE.gSaldoCred[i].vSaldAtual) > 0 then
        Gerador.wCampo(tcDe4, '#102', 'vSaldAtual', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vSaldAtual, DSC_VSALDATUAL)
      else
        Gerador.wCampo(tcInt, '#102', 'vSaldAtual', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vSaldAtual, DSC_VSALDATUAL);

      if (NF3e.gSCEE.gSaldoCred[i].vCredExpirar > 0) or
         (NF3e.gSCEE.gSaldoCred[i].CompetExpirar > 0) then
      begin
        if Frac(NF3e.gSCEE.gSaldoCred[i].vCredExpirar) > 0 then
          Gerador.wCampo(tcDe4, '#103', 'vCredExpirar', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vCredExpirar, DSC_VCREDEXPIRAR)
        else
          Gerador.wCampo(tcInt, '#103', 'vCredExpirar', 1, 15, 1, NF3e.gSCEE.gSaldoCred[i].vCredExpirar, DSC_VCREDEXPIRAR);

        Gerador.wCampo(tcStr, '#104', 'CompetExpirar', 6, 06, 1, FormatDateTime('yyyymm', NF3e.gSCEE.gSaldoCred[i].CompetExpirar), DSC_COMPETEXPIRAR);
      end;

      Gerador.wGrupo('/gSaldoCred');
    end;

    if NF3e.gSCEE.gSaldoCred.Count > 3 then
      Gerador.wAlerta('#098', 'gSaldoCred', '', ERR_MSG_MAIOR_MAXIMO + '3');

    Gerador.wGrupo('/gSCEE');
  end;
end;

procedure TNF3eW.GerarNFDet;
var
  i: Integer;
begin
  for i := 0 to NF3e.NFDet.Count - 1 do
  begin
    if NF3e.NFDet[i].chNF3eAnt <> '' then
    begin
      if NF3e.NFDet[i].mod6HashAnt <> '' then
        Gerador.wGrupo('NFdet chNF3eAnt="' + NF3e.NFDet[i].chNF3eAnt + '"' +
          ' mod6HashAnt="' + NF3e.NFDet[i].mod6HashAnt + '"', '#105')
      else
        Gerador.wGrupo('NFdet chNF3eAnt="' + NF3e.NFDet[i].chNF3eAnt + '"', '#105');

      if not ValidarChave(NF3e.NFDet[i].chNF3eAnt) then
        Gerador.wAlerta('#106', 'chNF3eAnt', DSC_CHNF3E, ERR_MSG_INVALIDO);
    end
    else
    begin
      if NF3e.NFDet[i].mod6HashAnt <> '' then
        Gerador.wGrupo('NFdet mod6HashAnt="' + NF3e.NFDet[i].mod6HashAnt + '"', '#105')
      else
        Gerador.wGrupo('NFdet', '#105');
    end;

     GerarDet(i);

    Gerador.wGrupo('/NFdet');
  end;

  if NF3e.NFDet.Count > 13 then
    Gerador.wAlerta('#105', 'NFdet', '', ERR_MSG_MAIOR_MAXIMO + '13');
end;

procedure TNF3eW.GerarDet(const i: Integer);
var
  j: Integer;
begin
  for j := 0 to NF3e.NFDet[i].Det.Count - 1 do
  begin
    Gerador.wGrupo('det nItem="' + IntToStr(NF3e.NFDet[i].Det[j].nItem) + '"', '#107');

    if NF3e.NFDet[i].Det[j].gAjusteNF3eAnt.tpAjuste <> taNenhum then
    begin
      Gerador.wGrupo('/gAjusteNF3eAnt', '#109');
      Gerador.wCampo(tcStr, '#110', 'tpAjuste ', 1, 1, 1, tpAjusteToStr(NF3e.NFDet[i].Det[j].gAjusteNF3eAnt.tpAjuste), DSC_TPAJUSTE);
      Gerador.wCampo(tcStr, '#111', 'motAjuste', 1, 1, 1, MotAjusteToStr(NF3e.NFDet[i].Det[j].gAjusteNF3eAnt.motAjuste), DSC_MOTAJUSTE);
      Gerador.wGrupo('/gAjusteNF3eAnt');
    end;

    if NF3e.NFDet[i].Det[j].detItemAnt.nItemAnt > 0 then
      GerarDetItemAnt(i, j)
    else
      GerarDetItem(i, j);

    Gerador.wGrupo('/det');
  end;

  if NF3e.NFDet[i].Det.Count > 990 then
    Gerador.wAlerta('#107', 'Det', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TNF3eW.GerarDetItemAnt(const i, j: Integer);
begin
  Gerador.wGrupo('detItemAnt nItemAnt="' +
              IntToStr(NF3e.NFDet[i].Det[j].detItemAnt.nItemAnt) + '"', '#112');

  // pode ter de 2 ou 6 casas decimais
  Gerador.wCampo(tcDe2, '#114', 'vItem    ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.vItem, DSC_VITEM);

  if Frac(NF3e.NFDet[i].Det[j].detItemAnt.qFaturada) > 0 then
    Gerador.wCampo(tcDe4, '#115', 'qFaturada', 1, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.qFaturada, DSC_QFATURADA)
  else
    Gerador.wCampo(tcInt, '#115', 'qFaturada', 1, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.qFaturada, DSC_QFATURADA);

  // pode ter de 2 ou 6 casas decimais
  Gerador.wCampo(tcDe2, '#116', 'vProd    ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.vProd, DSC_VPROD);
  Gerador.wCampo(tcStr, '#117', 'cClass   ', 7, 07, 1, NF3e.NFDet[i].Det[j].detItemAnt.cClass, DSC_CCLASS);
  Gerador.wCampo(tcDe2, '#118', 'vBC      ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItemAnt.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#119', 'pICMS    ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItemAnt.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#120', 'vICMS    ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItemAnt.vICMS, DSC_VICMS);
  Gerador.wCampo(tcDe2, '#121', 'vPIS     ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItemAnt.vPIS, DSC_VPIS);
  Gerador.wCampo(tcDe2, '#122', 'vCOFINS  ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItemAnt.vCOFINS, DSC_VCOFINS);

  if (NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vRetPIS > 0) or
     (NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vRetCOFINS > 0) or
     (NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vRetCSLL > 0) or
     (NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vBCIRRF > 0) or
     (NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vIRRF > 0) then
  begin
    Gerador.wGrupo('retTrib', '#123a');
    Gerador.wCampo(tcDe2, '#216', 'vRetPIS   ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vRetPIS, DSC_VRETPIS);
    Gerador.wCampo(tcDe2, '#217', 'vRetCOFINS', 01, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vRetCOFINS, DSC_VRETCOFINS);
    Gerador.wCampo(tcDe2, '#218', 'vRetCSLL  ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vRetCSLL, DSC_VRETCSLL);
    Gerador.wCampo(tcDe2, '#218', 'vBCIRRF   ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vBCIRRF, DSC_VBCIRRF);
    Gerador.wCampo(tcDe2, '#218', 'vIRRF     ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItemAnt.retTrib.vIRRF, DSC_VIRRF);
    Gerador.wGrupo('/retTrib');
  end;

  Gerador.wGrupo('/detItemAnt');
end;

procedure TNF3eW.GerarDetItem(const i, j: Integer);
begin
  if NF3e.NFDet[i].Det[j].detItem.nItemAnt > 0 then
  begin
    Gerador.wGrupo('detItem nItemAnt="' +
      IntToStr(NF3e.NFDet[i].Det[j].detItem.nItemAnt) + '"', '#123');

    if (NF3e.NFDet[i].Det[j].detItem.nItemAnt > 990) then
      Gerador.wAlerta('#124', 'nItemAnt', DSC_NITEMANT, ERR_MSG_MAIOR);
    if (NF3e.NFDet[i].Det[j].detItem.nItemAnt < 1) then
      Gerador.wAlerta('#124', 'nItemAnt', DSC_NITEMANT, ERR_MSG_MENOR);
  end
  else
   Gerador.wGrupo('detItem', '#123');

  GerargTarif(i, j);
  GerargAdBand(i, j);
  GerarDetProd(i, j);
  GerarImposto(i, j);
  GerargProcRef(i, j);
  GerargContab(i, j);

  Gerador.wCampo(tcStr, '#237', 'infAdProd', 1, 500, 0, NF3e.NFDet[i].Det[j].detItem.infAdProd, DSC_INFADPROD);

  Gerador.wGrupo('/detItem');
end;

procedure TNF3eW.GerargTarif(const i, j: Integer);
var
  k: Integer;
begin
  for k := 0 to NF3e.NFDet[i].Det[j].detItem.gTarif.Count - 1 do
  begin
    Gerador.wGrupo('gTarif', '#125');
    Gerador.wCampo(tcDat, '#126', 'dIniTarif', 10, 10, 1, NF3e.NFDet[i].Det[j].detItem.gTarif[k].dIniTarif, DSC_DINITARIF);
    Gerador.wCampo(tcDat, '#127', 'dFimTarif', 10, 10, 1, NF3e.NFDet[i].Det[j].detItem.gTarif[k].dFimTarif, DSC_DFIMTARIF);
    Gerador.wCampo(tcStr, '#128', 'tpAto    ', 01, 01, 1, tpAtoToStr(NF3e.NFDet[i].Det[j].detItem.gTarif[k].tpAto), DSC_TPATO);
    Gerador.wCampo(tcStr, '#129', 'nAto     ', 04, 04, 1, NF3e.NFDet[i].Det[j].detItem.gTarif[k].nAto, DSC_NATO);
    Gerador.wCampo(tcInt, '#130', 'anoAto   ', 04, 04, 1, NF3e.NFDet[i].Det[j].detItem.gTarif[k].anoAto, DSC_ANOATO);
    Gerador.wCampo(tcStr, '#131', 'tpTarif  ', 01, 01, 1, tpTarifToStr(NF3e.NFDet[i].Det[j].detItem.gTarif[k].tpTarif), DSC_TPTARIF);
    Gerador.wCampo(tcStr, '#132', 'cPosTarif', 01, 01, 1, cPosTarifToStr(NF3e.NFDet[i].Det[j].detItem.gTarif[k].cPosTarif), DSC_CPOSTARIF);
    Gerador.wCampo(tcStr, '#133', 'uMed     ', 01, 01, 1, uMedToStr(NF3e.NFDet[i].Det[j].detItem.gTarif[k].uMed), DSC_UMED);
    Gerador.wCampo(tcDe8, '#134', 'vTarifHom', 01, 17, 1, NF3e.NFDet[i].Det[j].detItem.gTarif[k].vTarifHom, DSC_VTARIFHOM);

    if NF3e.NFDet[i].Det[j].detItem.gTarif[k].vTarifAplic > 0 then
    begin
      Gerador.wCampo(tcDe8, '#135', 'vTarifAplic', 1, 17, 1, NF3e.NFDet[i].Det[j].detItem.gTarif[k].vTarifAplic, DSC_VTARIFAPLIC);
      Gerador.wCampo(tcStr, '#136', 'motDifTarif', 2, 02, 1, motDifTarifToStr(NF3e.NFDet[i].Det[j].detItem.gTarif[k].motDifTarif), DSC_MOTDIFTARIF);
    end;

    Gerador.wGrupo('/gTarif');
  end;

  if NF3e.NFDet[i].Det[j].detItem.gTarif.Count > 4 then
    Gerador.wAlerta('#125', 'gTarif', '', ERR_MSG_MAIOR_MAXIMO + '4');
end;

procedure TNF3eW.GerargAdBand(const i, j: Integer);
var
  k: Integer;
begin
  for k := 0 to NF3e.NFDet[i].Det[j].detItem.gAdBand.Count - 1 do
  begin
    Gerador.wGrupo('gAdBand', '#137');
    Gerador.wCampo(tcDat, '#138', 'dIniAdBand', 10, 10, 1, NF3e.NFDet[i].Det[j].detItem.gAdBand[k].dIniAdBand, DSC_DINITARIF);
    Gerador.wCampo(tcDat, '#139', 'dFimAdBand', 10, 10, 1, NF3e.NFDet[i].Det[j].detItem.gAdBand[k].dFimAdBand, DSC_DFIMTARIF);
    Gerador.wCampo(tcStr, '#140', 'tpBand    ', 01, 01, 1, tpBandToStr(NF3e.NFDet[i].Det[j].detItem.gAdBand[k].tpBand), DSC_TPBAND);
    Gerador.wCampo(tcDe2, '#141', 'vAdBand   ', 01, 06, 1, NF3e.NFDet[i].Det[j].detItem.gAdBand[k].vAdBand, DSC_VADBAND);

    if NF3e.NFDet[i].Det[j].detItem.gAdBand[k].vAdBandAplic > 0 then
    begin
      Gerador.wCampo(tcDe2, '#142', 'vAdBandAplic', 1, 06, 1, NF3e.NFDet[i].Det[j].detItem.gAdBand[k].vAdBandAplic, DSC_VADBANDAPLIC);
      Gerador.wCampo(tcStr, '#143', 'motDifBand  ', 2, 02, 1, motDifBandToStr(NF3e.NFDet[i].Det[j].detItem.gAdBand[k].motDifBand), DSC_MOTDIFBAND);
    end;

    Gerador.wGrupo('/gAdBand');
  end;

  if NF3e.NFDet[i].Det[j].detItem.gAdBand.Count > 3 then
    Gerador.wAlerta('#137', 'gAdBand', '', ERR_MSG_MAIOR_MAXIMO + '3');
end;

procedure TNF3eW.GerarDetProd(const i, j: Integer);
begin
  Gerador.wGrupo('prod', '#144');
  Gerador.wCampo(tcStr, '#145', 'indOrigemQtd', 1, 1, 1, indOrigemQtdToStr(NF3e.NFDet[i].Det[j].detItem.Prod.indOrigemQtd), DSC_INDORIGEMQTD);

  if NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.nMed > 0 then
    GerargMedicao(i, j);

  Gerador.wCampo(tcStr, '#161', 'cProd ', 01, 060, 1, NF3e.NFDet[i].Det[j].detItem.Prod.cProd, DSC_CPROD);
  Gerador.wCampo(tcStr, '#162', 'xProd ', 01, 120, 1, NF3e.NFDet[i].Det[j].detItem.Prod.xProd, DSC_XPROD);
  Gerador.wCampo(tcStr, '#163', 'cClass', 07, 007, 1, NF3e.NFDet[i].Det[j].detItem.Prod.cClass, DSC_CCLASS);
  Gerador.wCampo(tcInt, '#164', 'CFOP  ', 04, 004, 0, NF3e.NFDet[i].Det[j].detItem.Prod.CFOP, DSC_CFOP);
  Gerador.wCampo(tcStr, '#165', 'uMed  ', 01, 001, 1, uMedFatToStr(NF3e.NFDet[i].Det[j].detItem.Prod.uMed), DSC_UMED);

  if Frac(NF3e.NFDet[i].Det[j].detItem.Prod.qFaturada) > 0 then
    Gerador.wCampo(tcDe4, '#166', 'qFaturada', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.qFaturada, DSC_QFATURADA)
  else
    Gerador.wCampo(tcInt, '#166', 'qFaturada', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.qFaturada, DSC_QFATURADA);

  // pode ter 2 ou 8 casas decimais
  Gerador.wCampo(tcDe2, '#167', 'vItem', 01, 015, 1, NF3e.NFDet[i].Det[j].detItem.Prod.vItem, DSC_VITEM);
  // pode ter 2 ou 8 casas decimais
  Gerador.wCampo(tcDe2, '#168', 'vProd', 01, 015, 1, NF3e.NFDet[i].Det[j].detItem.Prod.vProd, DSC_VPROD);

  if NF3e.NFDet[i].Det[j].detItem.Prod.indDevolucao = tiSim then
    Gerador.wCampo(tcStr, '#169', 'indDevolucao', 1, 1, 1, '1', '');

  if NF3e.NFDet[i].Det[j].detItem.Prod.indPrecoACL = tiSim then
    Gerador.wCampo(tcStr, '#170', 'indPrecoACL', 1, 1, 1, '1', '');

  Gerador.wGrupo('/prod');
end;

procedure TNF3eW.GerargMedicao(const i, j: Integer);
begin
  Gerador.wGrupo('gMedicao', '#146');
  Gerador.wCampo(tcInt, '#147', 'nMed    ', 2, 2, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.nMed, DSC_NMED);
  Gerador.wCampo(tcInt, '#148', 'nContrat', 2, 2, 0, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.nContrat, DSC_NCONTRAT);

  if NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.tpMotNaoLeitura = tmNenhum then
  begin
    Gerador.wGrupo('gMedida', '#149');
    Gerador.wCampo(tcStr, '#150', 'tpGrMed  ', 2, 02, 1, tpGrMedToStr(NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.tpGrMed), DSC_TPGRMED);
    Gerador.wCampo(tcStr, '#151', 'cPosTarif', 1, 01, 1, cPosTarifToStr(NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.cPosTarif), DSC_CPOSTARIF);
    Gerador.wCampo(tcStr, '#152', 'uMed     ', 1, 01, 1, uMedFatToStr(NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.uMed), DSC_UMED);
    Gerador.wCampo(tcDe2, '#153', 'vMedAnt  ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.vMedAnt, DSC_VMEDANT);
    Gerador.wCampo(tcDe2, '#154', 'vMedAtu  ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.vMedAtu, DSC_VMEDATU);
    Gerador.wCampo(tcDe2, '#155', 'vConst   ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.vConst, DSC_VCONST);
    Gerador.wCampo(tcDe2, '#156', 'vMed     ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.vMed, DSC_VMED);

    if (NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.pPerdaTran > 0) or
       (NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.vMedPerdaTran > 0) then
    begin
      Gerador.wCampo(tcDe2, '#157', 'pPerdaTran   ', 1, 06, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.pPerdaTran, DSC_PPERDATRAN);
      Gerador.wCampo(tcDe2, '#158', 'vMedPerdaTran', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.vMedPerdaTran, DSC_VMEDPERDATRAN);
      Gerador.wCampo(tcDe2, '#159', 'vMedPerdaTec ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.vMedPerdaTec, DSC_VMEDPERDATEC);
    end;

    Gerador.wGrupo('/gMedida');
  end
  else
    Gerador.wCampo(tcStr, '#160', 'tpMotNaoLeitura', 1, 1, 1, tpMotNaoLeituraToStr(NF3e.NFDet[i].Det[j].detItem.Prod.gMedicao.tpMotNaoLeitura), DSC_TPMOTNAOLEITURA);

  Gerador.wGrupo('/gMedicao');
end;

procedure TNF3eW.GerarImposto(const i, j: Integer);
begin
  Gerador.wGrupo('imposto', '#171');

  GerarICMS(i, j);
  GerarPIS(i, j);
  GerarPISEfet(i, j);
  GerarCOFINS(i, j);
  GerarCOFINSEfet(i, j);
  GerarRetTrib(i, j);

  Gerador.wGrupo('/imposto');
end;

procedure TNF3eW.GerarICMS(const i, j: Integer);

  function BuscaTag(const t: TpcnCSTIcms): String;
  begin
    case t of
      cst00: result := '00';
      cst10: result := '10';
      cst20: result := '20';
      cst40,
      cst41: result := '40';
      cst51: result := '51';
      cst90: result := '90';
    end;
  end;

  function BuscaNumTag(const t: TpcnCSTIcms): String;
  begin
    case t of
      cst00: result := '172';
      cst10: result := '179';
      cst20: result := '186';
      cst40,
      cst41: result := '196';
      cst51: result := '200';
      cst90: result := '204';
    end;
  end;

var
  sTagTemp: String;

begin
  sTagTemp := BuscaTag(NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.CST);

  Gerador.wGrupo('ICMS' + sTagTemp, '#' + BuscaNumTag(NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.CST));

  Gerador.wCampo(tcStr, '#173', 'CST', 2, 2, 1, CSTICMSTOStr(NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.CST), DSC_CST);

  case NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.CST of
    cst00:
      begin
        Gerador.wCampo(tcDe2, '#174', 'vBC  ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vBC, DSC_VBC);
        Gerador.wCampo(tcDe2, '#175', 'pICMS', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pICMS, DSC_PICMS);
        Gerador.wCampo(tcDe2, '#176', 'vICMS', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMS, DSC_VICMS);

        if (NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pFCP > 0) or
           (NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vFCP > 0) then
        begin
          Gerador.wCampo(tcDe2, '#177', 'pFCP', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pFCP, DSC_PFCP);
          Gerador.wCampo(tcDe2, '#178', 'vFCP', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vFCP, DSC_VFCP);
        end;
      end;

    cst10:
      begin
        Gerador.wCampo(tcDe2, '#181', 'vBCST  ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vBCST, DSC_VBCST);
        Gerador.wCampo(tcDe2, '#182', 'pICMSST', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pICMSST, DSC_PICMSST);
        Gerador.wCampo(tcDe2, '#183', 'vICMSST', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMSST, DSC_VICMSST);

        if (NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pFCP > 0) or
           (NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vFCP > 0) then
        begin
          Gerador.wCampo(tcDe2, '#184', 'pFCPST', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pFCPST, DSC_PFCPST);
          Gerador.wCampo(tcDe2, '#185', 'vFCPST', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vFCPST, DSC_VFCPST);
        end;
      end;

    cst20:
      begin
        Gerador.wCampo(tcDe2, '#188', 'pRedBC', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pRedBC, DSC_PREDBC);
        Gerador.wCampo(tcDe2, '#189', 'vBC   ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vBC, DSC_VBC);
        Gerador.wCampo(tcDe2, '#190', 'pICMS ', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pICMS, DSC_PICMS);
        Gerador.wCampo(tcDe2, '#191', 'vICMS ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMS, DSC_VICMS);

        if NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMSDeson > 0 then
        begin
          Gerador.wCampo(tcDe2, '#192', 'vICMSDeson', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMSDeson, DSC_VICMSDESON);
          Gerador.wCampo(tcStr, '#193', 'cBenef    ', 10, 10, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.cBenef, DSC_CBENEF);
        end;

        if (NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pFCP > 0) or
           (NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vFCP > 0) then
        begin
          Gerador.wCampo(tcDe2, '#194', 'pFCP', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pFCP, DSC_PFCP);
          Gerador.wCampo(tcDe2, '#195', 'vFCP', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vFCP, DSC_VFCP);
        end;
      end;

    cst40,
    cst41:
      begin
        if NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMSDeson > 0 then
        begin
          Gerador.wCampo(tcDe2, '#198', 'vICMSDeson', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMSDeson, DSC_VICMSDESON);
          Gerador.wCampo(tcStr, '#199', 'cBenef    ', 10, 10, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.cBenef, DSC_CBENEF);
        end;
      end;

    cst51:
      begin
        if NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMSDeson > 0 then
        begin
          Gerador.wCampo(tcDe2, '#202', 'vICMSDeson', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMSDeson, DSC_VICMSDESON);
          Gerador.wCampo(tcStr, '#203', 'cBenef    ', 10, 10, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.cBenef, DSC_CBENEF);
        end;
      end;

    cst90:
      begin
        Gerador.wCampo(tcDe2, '#206', 'vBC  ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vBC, DSC_VBC);
        Gerador.wCampo(tcDe2, '#207', 'pICMS', 1, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.pICMS, DSC_PICMS);
        Gerador.wCampo(tcDe2, '#208', 'vICMS', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.ICMS.vICMS, DSC_VICMS);
      end;
  end;

  Gerador.wGrupo('/ICMS' + sTagTemp );
end;

procedure TNF3eW.GerarPIS(const i, j: Integer);
begin
  if (NF3e.NFDet[i].Det[j].detItem.Imposto.PIS.vBC > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.PIS.pPIS > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.PIS.vPIS > 0) then
  begin
    Gerador.wGrupo('PIS', '#209');
    Gerador.wCampo(tcStr, '#210', 'CST ', 02, 02, 1, CSTPISToStr(NF3e.NFDet[i].Det[j].detItem.Imposto.PIS.CST), DSC_CST);
    Gerador.wCampo(tcDe2, '#211', 'vBC ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.PIS.vBC, DSC_VBC);
    Gerador.wCampo(tcDe2, '#212', 'pPIS', 01, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.PIS.pPIS, DSC_PPIS);
    Gerador.wCampo(tcDe2, '#213', 'vPIS', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.PIS.vPIS, DSC_VPIS);
    Gerador.wGrupo('/PIS');
  end;
end;

procedure TNF3eW.GerarPISEfet(const i, j: Integer);
begin
  if (NF3e.NFDet[i].Det[j].detItem.Imposto.PISEfet.vBCPISEfet > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.PISEfet.pPISEfet > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.PISEfet.vPISEfet > 0) then
  begin
    Gerador.wGrupo('PISEfet', '#209');
    Gerador.wCampo(tcDe2, '#211', 'vBCPISEfet', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.PISEfet.vBCPISEfet, DSC_VBC);
    Gerador.wCampo(tcDe2, '#212', 'pPISEfet  ', 01, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.PISEfet.pPISEfet, DSC_PPIS);
    Gerador.wCampo(tcDe2, '#213', 'vPISEfet  ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.PISEfet.vPISEfet, DSC_VPIS);
    Gerador.wGrupo('/PISEfet');
  end;
end;

procedure TNF3eW.GerarCOFINS(const i, j: Integer);
begin
  if (NF3e.NFDet[i].Det[j].detItem.Imposto.COFINS.vBC > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.COFINS.pCOFINS > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.COFINS.vCOFINS > 0) then
  begin
    Gerador.wGrupo('COFINS', '#214');
    Gerador.wCampo(tcStr, '#215', 'CST    ', 02, 02, 1, CSTCOFINSToStr(NF3e.NFDet[i].Det[j].detItem.Imposto.COFINS.CST), DSC_CST);
    Gerador.wCampo(tcDe2, '#216', 'vBC    ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.COFINS.vBC, DSC_VBC);
    Gerador.wCampo(tcDe2, '#217', 'pCOFINS', 01, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.COFINS.pCOFINS, DSC_PCOFINS);
    Gerador.wCampo(tcDe2, '#218', 'vCOFINS', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.COFINS.vCOFINS, DSC_VCOFINS);
    Gerador.wGrupo('/COFINS');
  end;
end;

procedure TNF3eW.GerarCOFINSEfet(const i, j: Integer);
begin
  if (NF3e.NFDet[i].Det[j].detItem.Imposto.COFINSEfet.vBCCOFINSEfet > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.COFINSEfet.pCOFINSEfet > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.COFINSEfet.vCOFINSEfet > 0) then
  begin
    Gerador.wGrupo('COFINSEfet', '#214');
    Gerador.wCampo(tcDe2, '#216', 'vBCCOFINSEfet', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.COFINSEfet.vBCCOFINSEfet, DSC_VBC);
    Gerador.wCampo(tcDe2, '#217', 'pCOFINSEfet  ', 01, 05, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.COFINSEfet.pCOFINSEfet, DSC_PCOFINS);
    Gerador.wCampo(tcDe2, '#218', 'vCOFINSEfet  ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.COFINSEfet.vCOFINSEfet, DSC_VCOFINS);
    Gerador.wGrupo('/COFINS');
  end;
end;

procedure TNF3eW.GerarRetTrib(const i, j: Integer);
begin
  if (NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vRetPIS > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vRetCOFINS > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vRetCSLL > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vBCIRRF > 0) or
     (NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vIRRF > 0) then
  begin
    Gerador.wGrupo('retTrib', '#214');
    Gerador.wCampo(tcDe2, '#216', 'vRetPIS   ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vRetPIS, DSC_VRETPIS);
    Gerador.wCampo(tcDe2, '#217', 'vRetCOFINS', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vRetCOFINS, DSC_VRETCOFINS);
    Gerador.wCampo(tcDe2, '#218', 'vRetCSLL  ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vRetCSLL, DSC_VRETCSLL);
    Gerador.wCampo(tcDe2, '#218', 'vBCIRRF   ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vBCIRRF, DSC_VBCIRRF);
    Gerador.wCampo(tcDe2, '#218', 'vIRRF     ', 01, 15, 1, NF3e.NFDet[i].Det[j].detItem.Imposto.retTrib.vIRRF, DSC_VIRRF);
    Gerador.wGrupo('/retTrib');
  end;
end;

procedure TNF3eW.GerargProcRef(const i, j: Integer);
begin
  if NF3e.NFDet[i].Det[j].detItem.gProcRef.vItem > 0 then
  begin
    Gerador.wGrupo('gProcRef', '#219');

    // pode ter 2 ou 6 casas decimais
    Gerador.wCampo(tcDe2, '#220', 'vItem    ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.gProcRef.vItem, DSC_VITEM);

    if Frac(NF3e.NFDet[i].Det[j].detItem.gProcRef.qFaturada) > 0 then
      Gerador.wCampo(tcDe4, '#221', 'qFaturada', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.gProcRef.qFaturada, DSC_QFATURADA)
    else
      Gerador.wCampo(tcInt, '#221', 'qFaturada', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.gProcRef.qFaturada, DSC_QFATURADA);

    // pode ter 2 ou 6 casas decimais
    Gerador.wCampo(tcDe2, '#222', 'vProd    ', 1, 15, 1, NF3e.NFDet[i].Det[j].detItem.gProcRef.vProd, DSC_VPROD);

    if NF3e.NFDet[i].Det[j].detItem.gProcRef.indDevolucao = tiSim then
      Gerador.wCampo(tcStr, '#223', 'indDevolucao', 1, 1, 1, '1', '');

    Gerador.wCampo(tcDe2, '#224', 'vBC      ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItem.gProcRef.vBC, DSC_VBC);
    Gerador.wCampo(tcDe2, '#225', 'pICMS    ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItem.gProcRef.pICMS, DSC_PICMS);
    Gerador.wCampo(tcDe2, '#226', 'vICMS    ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItem.gProcRef.vICMS, DSC_VICMS);
    Gerador.wCampo(tcDe2, '#227', 'vPIS     ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItem.gProcRef.vPIS, DSC_VPIS);
    Gerador.wCampo(tcDe2, '#228', 'vCOFINS  ', 1, 15, 0, NF3e.NFDet[i].Det[j].detItem.gProcRef.vCOFINS, DSC_VCOFINS);

    GerargProc(i, j);

    Gerador.wGrupo('/gProcRef');
  end;
end;

procedure TNF3eW.GerargPIX;
begin
  Gerador.wGrupo('gPIX', '#251');
  Gerador.wCampo(tcStr, '#252', 'urlQRCodePIX', 2, 2000, 1, NF3e.gPIX.urlQRCodePIX, DSC_URLQRCODEPIX);
  Gerador.wGrupo('/gPIX');
end;

procedure TNF3eW.GerargProc(const i, j: Integer);
var
  k: Integer;
begin
  for k := 0 to NF3e.NFDet[i].Det[j].detItem.gProcRef.gProc.Count - 1 do
  begin
    Gerador.wGrupo('gProc', '#229');
    Gerador.wCampo(tcStr, '#230', 'tpProc   ', 1, 01, 1, tpProcToStr(NF3e.NFDet[i].Det[j].detItem.gProcRef.gProc[k].tpProc), DSC_TPPROC);
    Gerador.wCampo(tcStr, '#231', 'nProcesso', 1, 60, 1, NF3e.NFDet[i].Det[j].detItem.gProcRef.gProc[k].nProcesso, DSC_NPROCESSO);
    Gerador.wGrupo('/gProc');
  end;

  if NF3e.NFDet[i].Det[j].detItem.gProcRef.gProc.Count > 10 then
    Gerador.wAlerta('#229', 'gProc', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TNF3eW.GerargContab(const i, j: Integer);
var
  k: Integer;
begin
  for k := 0 to NF3e.NFDet[i].Det[j].detItem.gContab.Count - 1 do
  begin
    Gerador.wGrupo('gContab', '#232');
    Gerador.wCampo(tcStr, '#233', 'cContab', 9, 013, 1, NF3e.NFDet[i].Det[j].detItem.gContab[k].cContab, DSC_CCONTAB);
    Gerador.wCampo(tcStr, '#234', 'xContab', 1, 100, 1, NF3e.NFDet[i].Det[j].detItem.gContab[k].xContab, DSC_XCONTAB);
    Gerador.wCampo(tcDe2, '#235', 'vContab', 1, 015, 1, NF3e.NFDet[i].Det[j].detItem.gContab[k].vContab, DSC_VCONTAB);
    Gerador.wCampo(tcStr, '#236', 'tpLanc ', 1, 001, 1, tpLancToStr(NF3e.NFDet[i].Det[j].detItem.gContab[k].tpLanc), DSC_TPLANC);
    Gerador.wGrupo('/gContab');
  end;

  if NF3e.NFDet[i].Det[j].detItem.gContab.Count > 99 then
    Gerador.wAlerta('#232', 'gContab', '', ERR_MSG_MAIOR_MAXIMO + '99');
end;

procedure TNF3eW.GerarTotal;
begin
  Gerador.wGrupo('total', '#238');
  Gerador.wCampo(tcDe2, '#239', 'vProd', 1, 15, 1, NF3e.Total.vProd, DSC_VPROD);

  Gerador.wGrupo('ICMSTot', '#240');
  Gerador.wCampo(tcDe2, '#241', 'vBC       ', 1, 15, 1, NF3e.Total.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#242', 'vICMS     ', 1, 15, 1, NF3e.Total.vICMS, DSC_VICMS);
  Gerador.wCampo(tcDe2, '#243', 'vICMSDeson', 1, 15, 1, NF3e.Total.vICMSDeson, DSC_VICMSDESON);
  Gerador.wCampo(tcDe2, '#244', 'vFCP      ', 1, 15, 1, NF3e.Total.vFCP, DSC_VFCP);
  Gerador.wCampo(tcDe2, '#245', 'vBCST     ', 1, 15, 1, NF3e.Total.vBCST, DSC_VBCST);
  Gerador.wCampo(tcDe2, '#246', 'vST       ', 1, 15, 1, NF3e.Total.vST, DSC_VST);
  Gerador.wCampo(tcDe2, '#247', 'vFCPST    ', 1, 15, 1, NF3e.Total.vFCPST, DSC_VFCPST);
  Gerador.wGrupo('/ICMSTot');

  Gerador.wGrupo('vRetTribTot', '#240');
  Gerador.wCampo(tcDe2, '#241', 'vRetPIS   ', 1, 15, 1, NF3e.Total.vRetPIS, DSC_VRETPIS);
  Gerador.wCampo(tcDe2, '#242', 'vRetCofins', 1, 15, 1, NF3e.Total.vRetCofins, DSC_VRETCOFINS);
  Gerador.wCampo(tcDe2, '#243', 'vRetCSLL  ', 1, 15, 1, NF3e.Total.vRetCSLL, DSC_VRETCSLL);
  Gerador.wCampo(tcDe2, '#244', 'vIRRF     ', 1, 15, 1, NF3e.Total.vIRRF, DSC_VIRRF);
  Gerador.wGrupo('/vRetTribTot');

  Gerador.wCampo(tcDe2, '#248', 'vCOFINS    ', 1, 15, 1, NF3e.Total.vCOFINS, DSC_VCOFINS);
  Gerador.wCampo(tcDe2, '#248', 'vCOFINSEfet', 1, 15, 1, NF3e.Total.vCOFINSEfet, DSC_VCOFINSEfet);
  Gerador.wCampo(tcDe2, '#249', 'vPIS       ', 1, 15, 1, NF3e.Total.vPIS, DSC_VPIS);
  Gerador.wCampo(tcDe2, '#249', 'vPISEfet   ', 1, 15, 1, NF3e.Total.vPISEfet, DSC_VPISEfet);
  Gerador.wCampo(tcDe2, '#250', 'vNF        ', 1, 15, 1, NF3e.Total.vNF, DSC_VNF);
  Gerador.wGrupo('/total');
end;

procedure TNF3eW.GerargFat;
begin
  Gerador.wGrupo('gFat', '#251');
  Gerador.wCampo(tcStr, '#252', 'CompetFat   ', 06, 06, 1, FormatDateTime('yyyymm', NF3e.gFat.CompetFat), DSC_COMPETFAT);
  Gerador.wCampo(tcDat, '#253', 'dVencFat    ', 10, 10, 1, NF3e.gFat.dVencFat, DSC_DVENC);
  Gerador.wCampo(tcDat, '#254', 'dApresFat   ', 10, 10, 1, NF3e.gFat.dApresFat, DSC_DAPRESFAT);
  Gerador.wCampo(tcDat, '#255', 'dProxLeitura', 10, 10, 1, NF3e.gFat.dProxLeitura, DSC_DPROXLEITURA);
  Gerador.wCampo(tcStr, '#256', 'nFat        ', 01, 20, 0, NF3e.gFat.nFat, DSC_NFAT);
  Gerador.wCampo(tcStr, '#257', 'codBarras   ', 01, 48, 1, NF3e.gFat.codBarras, DSC_CODBARRAS);

  if NF3e.gFat.codBarras <> '' then
    Gerador.wCampo(tcStr, '#258', 'codDebAuto', 1, 20, 1, NF3e.gFat.codDebAuto, DSC_CODDEBAUTO)
  else
  begin
    Gerador.wCampo(tcStr, '#259', 'codBanco  ', 3, 05, 1, NF3e.gFat.codBanco, DSC_CODBANCO);
    Gerador.wCampo(tcStr, '#260', 'codAgencia', 1, 10, 1, NF3e.gFat.codAgencia, DSC_CODAGENCIA);
  end;

  if NF3e.gFat.enderCorresp.xLgr <> '' then
    GerarEnderCorresp;

  Gerador.wGrupo('/gFat');
end;

procedure TNF3eW.GerarEnderCorresp;
var
  cMun: Integer;
  xMun: String;
  xUF: String;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, 1058, NF3e.gFat.enderCorresp.UF, NF3e.gFat.enderCorresp.xMun, NF3e.gFat.enderCorresp.cMun);

  Gerador.wGrupo('enderCorresp', '#261');
  Gerador.wCampo(tcStr, '#262', 'xLgr   ', 2, 60, 1, NF3e.gFat.enderCorresp.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#263', 'nro    ', 1, 60, 1, NF3e.gFat.enderCorresp.nro, DSC_NRO);
  Gerador.wCampo(tcStr, '#264', 'xCpl   ', 1, 60, 0, NF3e.gFat.enderCorresp.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#265', 'xBairro', 1, 60, 1, NF3e.gFat.enderCorresp.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#266', 'cMun   ', 1, 07, 1, cMun, DSC_CMUN);

  if not ValidarMunicipio(cMun) then
    Gerador.wAlerta('#266', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#267', 'xMun', 2, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#268', 'CEP ', 8, 08, 0, NF3e.gFat.enderCorresp.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#269', 'UF  ', 2, 02, 1, xUF, DSC_UF);

  if not pcnAuxiliar.ValidarUF(xUF) then
    Gerador.wAlerta('#269', 'UF', DSC_UF, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#270', 'fone ', 6, 14, 0, OnlyNumber(NF3e.gFat.enderCorresp.fone), DSC_FONE);
  Gerador.wCampo(tcStr, '#271', 'email', 1, 60, 0, NF3e.gFat.enderCorresp.email, DSC_XPAIS);
  Gerador.wGrupo('/enderCorresp');
end;

procedure TNF3eW.GerargANEEL;
var
  i, j: Integer;
begin
  Gerador.wGrupo('gANEEL', '#272');

  for i := 0 to NF3e.gANEEL.gHistFat.Count - 1 do
  begin
    Gerador.wGrupo('gHistFat', '#273');
    Gerador.wCampo(tcStr, '#274', 'xGrandFat', 2, 60, 1, NF3e.gANEEL.gHistFat[i].xGrandFat, DSC_XGRANDFAT);

    for j := 0 to NF3e.gANEEL.gHistFat[i].gGrandFat.Count - 1 do
    begin
      Gerador.wGrupo('gGrandFat', '#275');
      Gerador.wCampo(tcStr, '#276', 'CompetFat', 6, 06, 1, FormatDateTime('yyyymm', NF3e.gANEEL.gHistFat[i].gGrandFat[j].CompetFat), DSC_COMPETFAT);
      Gerador.wCampo(tcDe2, '#277', 'vFat     ', 1, 15, 1, NF3e.gANEEL.gHistFat[i].gGrandFat[j].vFat, DSC_VFAT);
      Gerador.wCampo(tcStr, '#278', 'uMed     ', 1, 01, 1, uMedFatToStr(NF3e.gANEEL.gHistFat[i].gGrandFat[j].uMed), DSC_UMED);
      Gerador.wCampo(tcInt, '#279', 'qtdDias  ', 2, 02, 1, NF3e.gANEEL.gHistFat[i].gGrandFat[j].qtdDias, DSC_QTDE);
      Gerador.wGrupo('/gGrandFat');
    end;

    if NF3e.gANEEL.gHistFat[i].gGrandFat.Count > 13 then
      Gerador.wAlerta('#275', 'gGrandFat', '', ERR_MSG_MAIOR_MAXIMO + '13');

    Gerador.wGrupo('/gHistFat');
  end;

  if NF3e.gANEEL.gHistFat.Count > 5 then
    Gerador.wAlerta('#273', 'gHistFat', '', ERR_MSG_MAIOR_MAXIMO + '5');

  Gerador.wGrupo('/gANEEL');
end;

procedure TNF3eW.GerarautXML;
var
  i: Integer;
begin
  for i := 0 to NF3e.autXML.Count - 1 do
  begin
    Gerador.wGrupo('autXML', '#280');
    Gerador.wCampoCNPJCPF('#277', '#281', NF3e.autXML[i].CNPJCPF);
    Gerador.wGrupo('/autXML');
  end;

  if NF3e.autXML.Count > 10 then
    Gerador.wAlerta('#280', 'autXML', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TNF3eW.GerarInfAdic;
begin
  if (trim(NF3e.InfAdic.infAdFisco) <> '') or (trim(NF3e.InfAdic.infCpl) <> '') then
  begin
    Gerador.wGrupo('infAdic', '#283');
    Gerador.wCampo(tcStr, '#284', 'infAdFisco', 1, 2000, 0, NF3e.InfAdic.infAdFisco, DSC_INFADFISCO);
    Gerador.wCampo(tcStr, '#285', 'infCpl    ', 1, 5000, 0, NF3e.InfAdic.infCpl, DSC_INFCPL);
    Gerador.wGrupo('/infAdic');
  end;
end;

procedure TNF3eW.GerarinfRespTec;
begin
  if (NF3e.infRespTec.CNPJ <> '') then
  begin
    Gerador.wGrupo('gRespTec', '#286');
    Gerador.wCampoCNPJ('#287', NF3e.infRespTec.CNPJ, CODIGO_BRASIL, True);
    Gerador.wCampo(tcStr, '#288', 'xContato', 2, 60, 1, NF3e.infRespTec.xContato, DSC_XCONTATO);
    Gerador.wCampo(tcStr, '#289', 'email   ', 6, 60, 1, NF3e.infRespTec.email, DSC_EMAIL);
    Gerador.wCampo(tcStr, '#290', 'fone    ', 7, 12, 1, NF3e.infRespTec.fone, DSC_FONE);

    if (idCSRT <> 0) and (CSRT <> '') then
    begin
      Gerador.wCampo(tcInt, '#291', 'idCSRT  ', 02, 02, 1, idCSRT, DSC_IDCSRT);
      Gerador.wCampo(tcStr, '#292', 'hashCSRT', 28, 28, 1, CalcularHashCSRT(CSRT, FChaveNF3e), DSC_HASHCSRT);
    end;

    Gerador.wGrupo('/gRespTec');
  end;
end;

// Outras //////////////////////////////////////////////////////////////////////

procedure TNF3eW.AjustarMunicipioUF(out xUF: String; out xMun: String; out
  cMun: Integer; cPais: Integer; const vxUF, vxMun: String; vcMun: Integer);
var
  PaisBrasil: Boolean;
begin
  PaisBrasil := cPais = CODIGO_BRASIL;
  cMun := IIf(PaisBrasil, vcMun, CMUN_EXTERIOR);
  xMun := IIf(PaisBrasil, vxMun, XMUN_EXTERIOR);
  xUF :=  IIf(PaisBrasil, vxUF, UF_EXTERIOR);

  if FOpcoes.NormatizarMunicipios then
    if ( ( EstaZerado(cMun)) and (xMun <> XMUN_EXTERIOR) ) then
      cMun := ObterCodigoMunicipio(xMun, xUF, FOpcoes.FPathArquivoMunicipios)
    else if ( ( EstaVazio(xMun)) and (cMun <> CMUN_EXTERIOR) ) then
      xMun := ObterNomeMunicipio(xUF, cMun, FOpcoes.FPathArquivoMunicipios);
end;

end.

