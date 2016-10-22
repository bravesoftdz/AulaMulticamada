{  Arquivo criado automaticamente Gerador Multicamadas
   (Multitiers Generator VERS�O 0.01)
   Data e Hora: 11/10/2016 - 23:02:06
}

unit Marvin.AulaMulticamada.Cadastro.TipoCliente;

interface

uses
  Classes,
  { marvin }
  uMRVClasses,
  uMRVCadastroBase,
  uMRVClassesServidor,
  Marvin.AulaMulticamada.Classes.TipoCliente,
  Marvin.AulaMulticamada.Listas.TipoCliente,
  Marvin.AulaMulticamada.Repositorio.TipoCliente;

type
  TMRVCadastroTipoCliente = class(TMRVCadastroBase)
  private
    FTipoCliente: IMRVRepositorioTipoCliente;
  protected
    procedure DoAlterar(const AItem: TMRVDadosBase); override;
    procedure DoExcluir(const AItem: TMRVDadosBase); override;
    procedure DoInserir(const AItem: TMRVDadosBase); override;
    function DoProcurarItem(const ACriterio: TMRVDadosBase; const AResultado:
      TMRVDadosBase = nil): Boolean; override;
    function DoProcurarItems(const ACriterio: TMRVDadosBase; const
      AListaResultado: TMRVListaBase; const ASearchOption: TMRVSearchOption):
      Boolean; override;
    procedure FazerValidacoesDeRegras(AItem: TMRVDadosBase); override;
  public
    constructor Create(var ARepositorio: IMRVRepositorioTipoCliente);
      reintroduce; virtual;
    destructor Destroy; override;
    property TipoCliente: IMRVRepositorioTipoCliente read FTipoCliente write FTipoCliente;
  end;

implementation

uses
  Marvin.AulaMulticamada.Excecoes.TipoCliente,
  uMRVConsts;

{ TMRVCadastroTipoCliente }

constructor TMRVCadastroTipoCliente.Create(var ARepositorio: IMRVRepositorioTipoCliente);
begin
  inherited Create;
  { recebe a refer�ncia do objeto criado na Fachada }
  FTipoCliente := ARepositorio;
end;

destructor TMRVCadastroTipoCliente.Destroy;
begin
  FTipoCliente := nil;
  inherited;
end;

procedure TMRVCadastroTipoCliente.DoAlterar(const AItem: TMRVDadosBase);
begin
  Assert(AItem <> nil, 'O par�metro AItem n�o pode ser NIL.');
  { verifica se j� foi o cadastro anteriormente }
  if not Self.ProcurarItem(AItem) then
  begin
    raise EMRVTipoClienteNaoCadastrado.Create;
  end;
  { verificar regras de neg�cio }
  Self.FazerValidacoesDeRegras(AItem);
  { manda o Reposit�rio alterar o objeto }
  FTipoCliente.Alterar(AItem);
end;

procedure TMRVCadastroTipoCliente.DoExcluir(const AItem: TMRVDadosBase);
begin
  Assert(AItem <> nil, 'Par�metro AItem n�o pode ser NIL.');
  { verifica se j� foi o cadastro anteriormente }
  if not Self.ProcurarItem(AItem) then
  begin
    raise EMRVTipoClienteNaoCadastrado.Create;
  end;
  { valida as regras de neg�cio }
  Self.FazerValidacoesDeRegras(AItem);
  { manda o Reposit�rio excluir o objeto }
  FTipoCliente.Excluir(AItem);
end;

procedure TMRVCadastroTipoCliente.DoInserir(const AItem: TMRVDadosBase);
var
  LTipoCliente: TMRVTipoCliente;

  procedure LPesquisar(AChave: array of string);
  var
    LSearchOption: TMRVSearchOption;
    LListaTipoCliente: TMRVListaTipoCliente;
  begin
    LSearchOption := TMRVSearchOption.Create(LTipoCliente);
    try
      LSearchOption.SetSearchingFor(AChave);
      LListaTipoCliente := TMRVListaTipoCliente.Create;
      try
        if Self.ProcurarItems(LTipoCliente, LListaTipoCliente, LSearchOption) then
        begin
            { se encontrou }
          raise EMRVTipoClienteJaCadastrado.Create;
        end;
      finally
         { libera a lista }
        LListaTipoCliente.Free
      end;
    finally
         { libera o crit�rio de procura }
      LSearchOption.Free;
    end;
  end;

begin
  Assert(AItem <> nil, 'O par�metro AItem n�o pode ser NIL.');
  { realiza o typecast }
  LTipoCliente := AItem as TMRVTipoCliente;
  { Faz uma pesquisa pela chave do objeto a ser inserido }
  LPesquisar(['Descricao']);
  { recupera o pr�ximo id }
  LTipoCliente.TipoClienteId := FTipoCliente.GetNextId;
  { Faz as verifica��es das colunas que n�o podem ser nulas }
  Self.FazerValidacoesDeRegras(AItem);
  { manda o Reposit�rio inserir o objeto }
  FTipoCliente.Inserir(AItem);
end;

function TMRVCadastroTipoCliente.DoProcurarItem(const ACriterio: TMRVDadosBase;
  const AResultado: TMRVDadosBase = nil): Boolean;
begin
  { verifica se existe um objeto inicializado para ACriterio }
  Assert(ACriterio <> nil, 'O par�metro ACriterio n�o pode ser NIL.');
  { manda o reposit�rio procurar o objeto }
  Result := FTipoCliente.ProcurarItem(ACriterio, AResultado);
end;

function TMRVCadastroTipoCliente.DoProcurarItems(const ACriterio: TMRVDadosBase;
  const AListaResultado: TMRVListaBase; const ASearchOption: TMRVSearchOption): Boolean;
begin
  { verifica se existe um objeto inicializado para ACriterio }
  Assert(ACriterio <> nil, 'Par�metro ACriterio n�o pode ser NIL.');
  { verifica se existe um objeto inicializado para AListaResultado }
  Assert(AListaResultado <> nil, 'Par�metro AListaResultado n�o pode ser NIL.');
  { verifica se existe um objeto inicializado para ASearchOption }
  Assert(ASearchOption <> nil, 'O par�metro ASearchOption n�o pode ser nil.');
  { manda o reposit�rio procurar }
  Result := FTipoCliente.ProcurarItems(ACriterio, AListaResultado, ASearchOption);
end;

procedure TMRVCadastroTipoCliente.FazerValidacoesDeRegras(AItem: TMRVDadosBase);
var
  LTipoCliente: TMRVTipoCliente;
begin
  { verifica se existe um objeto inicializado para AItem }
  Assert(AItem <> nil, 'O par�metro AItem n�o pode ser NIL.');
  LTipoCliente := AItem as TMRVTipoCliente;

  { Valida as regras de neg�cio }
  { checa se a propriedade � nula }
  if LTipoCliente.TipoClienteId = C_INTEGER_NULL then
  begin
    raise EMRVTipoClienteTipoClienteIdInvalido.Create;
  end;
   { checa se a propriedade � nula }
  if LTipoCliente.Descricao = C_STRING_NULL then
  begin
    raise EMRVTipoClienteDescricaoInvalida.Create;
  end;
   { checa se n�o ultrapassa o tamanho m�ximo de caracteres }
  if Length(LTipoCliente.Descricao) > 100 then
  begin
    raise EMRVTipoClienteDescricaoTamanhoInvalido.Create(100);
  end;
end;

end.


