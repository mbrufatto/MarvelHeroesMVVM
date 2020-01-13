# Marvel Heroes

Para este projeto foi utilizado o Cocoapods, para gerenciar as bibliotecas utilizadas. No projeto foram utilizadas as seguintes bibliotecas:

CryptoSwift - Biblioteca para encriptar informações;
Kingfisher - Biblioteca para realizar download de imagens.

## Instrução

Acessar a pasta do projeto e executar o seguinte comando:

pod install

Com isso as bibliotecas serão instaladas. Duranta a instalação das bibliotecas.

Após a instalação abra o xcode -> File -> Open -> Selecione a pasta onde o projeto foi salvo -> Abra o arquivo
MarvelHerosMVVM.xcworkspace

Após o projeto aberto é só executar.

## Breve descrição

Ao abrir o app, demorará alguns segundos para que os personagens da marvel apareçam. Após aparecer os primeiros personagens
é possível ver mais persoganes executando a rolagem, com isso será carregado mais personagens na tela. Também, é possível 
realizar a busca por personagens, mas a busca só funciona com os personagens carregados, pois a API não oferece um endpoint
para buscar uma personagem pelo seu nome. O usuário, também pode clicar em qualquer personagem, quando fizer isso será mostrada
as  informações do personagem, juntamente com as revistas em quadrinhos em que ele aparece (para aparecer os quadrinhos pode 
demorar alguns segundos). Na tela dos detalhes o usuário também poderá realizar a rolagem, para que sejam carregados mais 
quadrinhos.

## Testes
Neste projeto foram criados alguns testes. Para executar os testes, basta abrir o projeto no Xcode e precionar as teclas 
Command + U.

## Melhorias
Adicionar um load nas telas de carregamento de dados;
Adicionar icone ao projeto;
Adicionar uma tela de splash;
Adicionar o arquivo gitignore.

