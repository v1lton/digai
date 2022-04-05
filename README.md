# digai
Jogo de stop com músicas do Spotify.

## Requisitos
- iOS 14.0+
- Xcode 12.0+

### Spotify API
Para rodar o app no Xcode é necessário criar uma aplicação no [Spotify para desenvolvedores](https://developer.spotify.com/). 

Siga o [passo a passo](https://developer.spotify.com/documentation/general/guides/authorization/app-settings/) para o setup.

## Setup
### Spotify API
Depois da criação e do setup, crie um arquivo chamado `SpotifyConfig` contendo as seguintes variáveis com os dados da sua aplicação:

```swift
// SpotifyConfig.swift

let spotifyRedirectURL = "REDIRECT URI"
let spotifyClientID = "CLIENT ID"
let spotifyClientSecretKey = "CLIENT SECRET"

```

Você pode colocá-las em outro lugar se preferir, mas tome cuidado para não subir em um repositório remoto.
