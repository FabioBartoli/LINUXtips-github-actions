# Desafio 03 – Containers e Segurança (GHCR)

Opa, beleza? Foi mal estar atrapalhando seu sextou aí, mas a gente tá com um problema aqui na empresa e precisamos da sua ajuda. Seguinte, aquela aplicação que implementamos os pipelines iniciais de setup e os testes agora está sofrendo uma modernização e vai passar a utilizar docker. Com isso, precisamos que você crie pra gente um terceiro pipeline que faça o seguinte:

## Requisitos do pipeline

- Deve existir um novo workflow do GitHub Actions para o Nível 3 (containers e segurança).
- O disparo deve acontecer quando um Pull Request para a branch `main` for fechado com merge (evento `pull_request`, `types: [closed]` + condição `github.event.pull_request.merged == true`).
- O workflow deve:
  - Fazer login no GitHub Container Registry (GHCR) utilizando `GITHUB_TOKEN`.
  - Montar a tag da imagem sempre com o SHA do commit, e com `owner`, `IMAGE_NAME` e `registry` em minúsculas.
  - Executar lint do `Dockerfile` com **Hadolint**, salvando o resultado em `lint-report.txt` e falhando se forem encontrados os problemas **DL3006**, **DL3008** ou **DL4006**.
  - Construir a imagem Docker localmente (com `load`) para permitir o scan de vulnerabilidades.
  - Executar o scan de vulnerabilidades com **Trivy** na imagem construída.
    - O resultado deve ser salvo em um relatório `trivy-report.txt` e publicado como artefato, mesmo que não haja falhas.
    - O workflow deve falhar caso o Trivy encontre vulnerabilidades de severidade **CRITICAL**.
  - Executar um **smoke test** da imagem rodando `node --version`. Caso não haja saída, o job deve falhar.
  - Somente publicar no GHCR se **todas** as validações acima forem aprovadas.
  - Gerar o artefato `level-3-certificate.md` (não alterar a seção do certificado, assim como nos desafios anteriores).

## Variável obrigatória

- Crie uma variável de repositório chamada `IMAGE_NAME` (em: Settings > Secrets and variables > Actions > Variables) com o nome da aplicação a ser usada no nome da imagem (ex.: `desafio3-linuxtips-gha`).
- Essa variável é obrigatória e será utilizada para compor o nome final da imagem no GHCR.

## Actions obrigatórias

Você deve utilizar exatamente estas actions nas versões a seguir:

- `docker/login-action@v3`
- `docker/build-push-action@v6`
- `aquasecurity/trivy-action@0.28.0`
- `docker/build-push-action@v6` (para o push final após o scan)

## Regras de publicação da imagem

- **Registry**: `ghcr.io`
- **Tag obrigatória**: o SHA do commit (`${{ github.sha }}`)
- **Nome completo (exemplo)**: `ghcr.io/<owner>/<IMAGE_NAME>:<sha>`
- O nome completo deve ser convertido para minúsculas para evitar erros no push.

## Critérios de aceite

- [ ] Workflow Nível 3 dispara somente após PR mergeado na `main`.
- [ ] `Dockerfile` analisado com **Hadolint**; gerar artefato `lint-report.txt`.
- [ ] O workflow falha se Hadolint encontrar **DL3006**, **DL3008** ou **DL4006**.
- [ ] Imagem construída localmente e escaneada com **Trivy**.
- [ ] Relatório `trivy-report.txt` gerado e publicado como artefato.
- [ ] Workflow falha se o scan encontrar vulnerabilidades CRITICAL.
- [ ] Smoke test da imagem executa `node --version` e falha se não houver saída.
- [ ] Push realizado no GHCR apenas se todas as verificações passarem.
- [ ] Tag da imagem é exatamente o SHA do commit.
- [ ] Nome completo da imagem em minúsculas.
- [ ] Uso das actions nas versões exigidas.
- [ ] Artefato `level-3-certificate` com o arquivo `level-3-certificate.md` disponível nos artefatos do run.

Boa sorte e nos vemos no sábado, dia 20/09, para resolver esse desafio na nossa live das 13h

#VAI
