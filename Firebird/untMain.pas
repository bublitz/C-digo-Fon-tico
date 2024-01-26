unit untMain;

interface

uses
  SysUtils;

function CodiFonPT_BR(nome: PChar): PChar; cdecl; export;

implementation

function CodiFonPT_BR(nome: PChar): PChar;
var
  i: integer;
  novo, aux: string;

begin
  try
    // Adicione SysUtils em uses
    aux := AnsiUpperCase(nome);

    // Tira acentos
    aux := StringReplace(aux, '�', 'A', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'A', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'A', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'A', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'A', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'A', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'E', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'E', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'E', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'E', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'I', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'I', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'I', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'I', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'O', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'O', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'O', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'O', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'O', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'U', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'U', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'U', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'U', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'S', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'N', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'Y', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, '�', 'Y', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, 'Y', 'Y', [rfReplaceAll, rfIgnoreCase]);

    for i := 1 to Length(aux) do
      if Ord(aux[i]) > 127 then
        aux[i] := #32;

    // Retira E , DA, DE e DO do nome
    // Jos� da Silva = Jos� Silva
    // Jo�o Costa e Silva = Jo�o Costa Silva
    aux := StringReplace(aux, ' DA ', '', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, ' DAS ', '', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, ' DE ', '', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, ' DI ', '', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, ' DO ', '', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, ' DOS ', '', [rfReplaceAll, rfIgnoreCase]);
    aux := StringReplace(aux, ' E ', '', [rfReplaceAll, rfIgnoreCase]);

    // Retira letras duplicadas
    // Elizabette = Elizabete
    for i := 1 to Length(aux)-1 do
      if aux[i] = aux[i+1] then
        Delete(aux, i, 1);

    {
      As altera��es nas regras abaixo s�o sugest�es do
      Vin�cius de Lucena Bonoto,
      monografia
      Bacharel em Ci�ncia da Computa��o
      FAGOC - Faculdade Governador Ozanam Coelho
      Ub�/MG - 2011
    }

    novo := '';
    for i := 1 to Length(aux) do
    begin
      case aux[i] of
        // 'A','E','I','O','U','Y','H' e espa�os: ignora

        'B','D','F','J','K','L','M','R','T','V':
          novo := novo + aux[i];

        'C':  // CH = X
          if aux[i+1] = 'H' then
            novo := novo + 'X'
          else // Carol = Karol
          if CharInSet(aux[i+1], ['A','O','U']) then
            novo := novo + 'K'
          else
          if aux[i-1] = 'X' then
            novo := novo + 'S'
          else // Celina = Selina
          if CharInSet(aux[i+1], ['E','I']) then
            novo := novo + 'S'
          else
          if CharInSet(aux[i+1], ['R','L']) then
            novo := novo + 'K';

        'G': // Jeferson = Geferson
          if CharInSet(aux[i+1], ['E','I']) then
            novo := novo + 'J'
          else
            novo := novo + 'G';

        'N': // Nilton e Niltom
          if (i = Length(aux)) or (aux[i+1] = ' ') then
            novo := novo + 'M'
          else
            novo := novo + 'N';

        'P': // Phelipe = Felipe
           if aux[i+1] = 'H' then
             novo := novo + 'F'
           else
             novo := novo + 'P';

        'Q': // Keila = Queila
           if aux[i+1] = 'U' then
             novo := novo + 'K'
           else
             novo := novo + 'Q';

        'S':
           case aux[i+1] of
             'H': // SH = X
               novo := novo + 'X';

             'A','E','I','O','U':
               if CharInSet(aux[i-1], ['A','E','I','O','U']) then
                 novo := novo + 'Z' // S entre duas vogais = Z
               else
                 novo := novo + 'S';
           else
             if aux[i-1] = 'C' then
              novo := novo + 'KS'
             else
               if (i = Length(aux)) or (aux[i+1] = ' ') then
                 novo := novo + 'S';
           end;

        'U':
           if CharInSet(aux[i - 1], ['A','E','I','O','U']) then
             novo := novo + 'L';

        'W': // Walter = Valter
           novo := novo + 'V';

        'X': // Walter = Valter
          if (i = Length(aux)) or (aux[i+1] = ' ') then
             novo := novo + 'KS'
           else
             novo := novo + 'X';

        'Z': // no final do nome tem som de S -> Luiz = Luis
           if (i = Length(aux)) or (aux[i+1] = ' ') then
             novo := novo + 'S'
           else
             if (i = Length(aux)) or (aux[i+1] = ' ') then
               novo := novo + 'S' ;
      end;
    end;

    CodiFonPT_BR := PChar(novo);
  except
    CodiFonPT_BR := PChar('');
  end;
end;

end.
