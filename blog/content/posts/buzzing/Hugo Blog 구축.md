---
title: "Hugo Blog 구축 - 수정중"
date: 2022-03-01
categories: ["buzzing"]
tags: ["project", "blog", "hugo", "github"]
# cover: "/assets/posts/buzzing/20220301_HugoBlog구축/thumbnail.png"
cover: "/images/buzzing/20220301_HugoBlog구축/thumbnail.png"
draft: false
---

## Hugo 설치

> 글에 들어가기 앞서, 해당 설치환경은 윈도우 11 기준으로 작성되었음을 알립니다.


## 세팅 전 필수 프로그램 설치

[Git](https://git-scm.com/)

[Go](https://go.dev/dl/)

해당 사이트에서 Git과 Go를 다운받습니다.

Chocolatey를 사용하는 경우, 아래 코드를 입력하여 Go와 Git을 설치할 수 있습니다.

```
PS ../> choco install git golang
```

## Github 저장소 생성

Hugo는 Github Repository를 2개 생성해야합니다.

Repository Name은 `github닉네임.github.io`와 `blog` 로 생성합니다.

주의해야할 점은 Repository 생성 시 **README.md를 만들지 말아야합니다**. 나중에 충돌이 발생할 수 있습니다.

![github_01](/assets/posts/buzzing/20220301_HugoBlog구축/blog_01.png)

![github_02](/assets/posts/buzzing/20220301_HugoBlog구축/github_02.png)

생성되었다면 `git clone`을 통해 컴퓨터에 만든 저장소를 복제합니다.

```
PS ../> git clone https://github.com/nickname/blog.git
```

## Hugo 설치

[Releases · gohugoio/hugo](https://github.com/gohugoio/hugo/releases)

해당 사이트에서 Hugo를 다운받습니다.

Chocolatey를 사용하는 경우, 아래 코드를 입력하여 Hugo를 설치할 수 있습니다.

```
PS ../> choco install hugo -confirm
```

`hugo version`을 입력하여 정상적으로 설치되었는지 확인할 수 있습니다.

## Hugo 블로그 생성

`hugo new site 생성할폴더명`을 입력하여 Hugo 블로그를 생성합니다.

여기서는 폴더명을 `blog`로 지정하여 생성하겠습니다.

```
PS ../blog> hugo new site blog
```

## Hugo 테마 설정

Hugo는 처음 생성하면 아무것도 페이지가 존재하지 않아 실행시켜도 빈페이지만 나오게됩니다.

[https://themes.gohugo.io/](https://themes.gohugo.io/)

위의 사이트에 접속해서 원하시는 테마를 선택했다면 각 테마의 Documentation을 참고하여 테마를 추가합니다.

필자는 [Hello Programmer](https://blog.lulab.net/projects/2019-05-hugo-hello-programmer-theme-v2/)테마를 사용합니다.

```
PS ../blog/blog> cd themes
PS ../blog/blog/themes> git clone https://github.com/lubang/hugo-hello-programmer-theme
```

그런다음 상위 폴더의 `config.toml`파일을 수정합니다.

```
baseURL = "https://SeungHyeokJeon.github.io/" # 해당 블로그 주소를 입력합니다
title = "블로그제목"

languageCode = "kr-ko"
theme = "hugo-hello-programmer-theme"
disqusShortname = "개별설정"
googleAnalytics = "개별설정"
paginate = 7

[author]
    name = "이름"
    email = "이메일"

[params]
    description = "블로그 설명"
```

설정을 다했다면 로컬서버를 실행시켜 제대로 적용됐는지 확인해봅니다.

```
PS ../blog/blog> hugo server
```

https://localhost:1313 또는 https://127.0.0.1:1313 으로 접속할 수 있습니다.

![blog](/assets/posts/buzzing/20220301_HugoBlog구축/blog_01.png)

## Git Repository 연결 및 배포 스크립트 작성

blog 폴더에서 public 폴더를 submodule하여 `nickname.github.io` repository에 연결합니다.

```
PS ../blog/blog> git submodule add -b master https://github.com/nickname/nickname.github.io.git public
```

폴더를 생성했다면 폴더 구조는 아래와 같이 될 것입니다.

```
└── blog
    ├── .git
    └── blog
        ├── archetypes
        ├── content
        ...
            ├── public
            ...
        └── comfig.toml
```

그런 다음 배포용 스크립트를 생성하기 위해 blog 폴더 최상단에 `deploy.bat`를 생성하고 아래 내용을 입력합니다.

```
@ECHO OFF

@REM Define commit message
SET param=%*

ECHO Deploying updates to GitHub...

cd blog

@REM Build the project
hugo -t hugo-hello-programmer-theme

@REM Define commit message
SET msg=rebuilding site %DATE% %TIME%
IF defined param (
    SET msg=%param%
)
echo %msg%

@REM Submodule commit
cd public
git add .
git commit -m "%msg%"
git push origin main

@REM Main blog commit
cd ../..
git add .
git commit -m "%msg%"
git push origin main
```

파일을 저장하고 아래처럼 파일을 실행시켜 git push를 진행합니다.

커밋내용은 작성하지 않으면 `rebuilding site 날짜 시간` 형식으로 작성됩니다.

```
PS ../blog> ./deploy.bat (커밋내용)
```

## Reference
[https://gohugo.io/getting-started/installing/](https://gohugo.io/getting-started/installing/)

[https://velog.io/@mellonggo/Github-페이지-블로그-만들기-with-Hugo](https://velog.io/@mellonggo/Github-%ED%8E%98%EC%9D%B4%EC%A7%80-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%A7%8C%EB%93%A4%EA%B8%B0-with-Hugo)

[https://gurumee92.github.io/2020/08/블로그-구축기-1-hugo-github으로-개인-블로그-만들기/](https://gurumee92.github.io/2020/08/%EB%B8%94%EB%A1%9C%EA%B7%B8-%EA%B5%AC%EC%B6%95%EA%B8%B0-1-hugo-github%EC%9C%BC%EB%A1%9C-%EA%B0%9C%EC%9D%B8-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%A7%8C%EB%93%A4%EA%B8%B0/)