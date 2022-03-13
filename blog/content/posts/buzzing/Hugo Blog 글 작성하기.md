---
title: "Hugo Blog 글 작성하기"
date: 2022-03-13
categories: ["buzzing"]
tags: ["project", "blog", "hugo", "github"]
# cover: "/images/buzzing/20220301_HugoBlog구축/thumbnail.png"
draft: false
---

> 글에 들어가기 앞서, 이 글은 윈도우 10, 11 기준으로 작성되었음을 알립니다.

## 파일 위치

### 게시글
Hugo Blog의 게시글이 되는 markdown 파일은 `/blog/content/posts` 아래에 위치합니다.
```
└── blog
    ├── .git
    └── blog
        ├── archetypes
        ├── content
            └── posts
                ├── buzzing
                    └── Hugo Blog 글 작성하기.md
                ...
        ...
        └── comfig.toml
```
사람마다 게시글을 관리하는 방법을 제각각이지만, 저는 `posts`아래에 `category`폴더를 따로 만들어 카테고리별로 게시글을 관리하고 있습니다.

### 이미지, 동영상 등 첨부파일
Hugo Blog에서 이미지나 동영상 등 첨부파일이 렌더링 되는 위치는 `/blog/static` 아래에 위치합니다.
```
└── blog
    ├── .git
    └── blog
        ├── archetypes
        ...
        ├── static
            └── buzzing
                ├── 20220313_HugoBlog글작성하기
                    └── image.jpeg
                ...
        ...
        └── comfig.toml
```
보통은 `static`아래에 `images`나 `videos` 같은 폴더로 분류하는게 정석이지만, 저는 `static` 아래에 `category`와 `게시글`로 분류하여 파일을 관리하고 있습니다.

## 기본 정보 작성

글의 제목이나 작성날짜, 카테고리 등 글에 대한 기본 정보를 작성하는 부분입니다.
```
---
title: "Hugo Blog 이미지 삽입하기"
date: 2022-03-13
categories: ["buzzing"]
tags: ["project", "blog", "hugo", "github"]
# cover: "/images/buzzing/20220301_HugoBlog구축/thumbnail.png"
draft: false
---
```
글의 최상단에 위치하며 수정할 수 있는 값은 title, date, categories, tags, cover, draft가 있습니다.

각 항목에 대해 조금씩 살펴보자면,
- **title → 글의 제목**, 브라우저의 타이틀바와 블로그에서 보여지는 글의 제목입니다.
- **date → 글을 쓴 날짜**, 기본적으로 날짜+시간을 보여주지만, 현재 저는 날짜만 출력되도록 사용하고 있습니다.
- **categories → 글의 카테고리**, 여러 개를 지정하고 싶은 경우, 중괄호 안에 `,`로 구분하여 작성합니다.
- **tags → 글의 태그**, categories와 마찬가지로 여러 개를 지정하고 싶은 경우, 중괄호 안에 `,`로 구분하여 작성합니다.
- **cover → 글의 썸네일 이미지**, **로컬 경로**를 입력해줄 수 있고, **URL** 형태로도 지원합니다.
- **draft → 글을 보여줄지 결정하는 변수**, draft를 true로 설정하게 되면 Hugo는 해당 글을 렌더링하지 않아 블로그에 출력되지 않습니다.

## 이미지 삽입 방법

이미지를 삽입하기 위해서는 `static` 아래에 있는 경로와 함께 파일명을 적어주어야 합니다.

```
<!-- image 경로 /blog/static/buzzing/20220313_HugoBlog글작성하기/image.png -->
![image](/buzzing/20220313_HugoBlog글작성하기/github_02.png)
```
이미지의 경로는 static까지의 경로는 적지 않고, static 아래의 경로부터 적어줍니다.

이유는 Hugo Blog 렌더링을 진행하면 

![image](/buzzing/20220313_HugoBlog글작성하기/github_02.png)


## Reference
[https://gohugo.io/getting-started/installing/](https://gohugo.io/getting-started/installing/)

[https://velog.io/@mellonggo/Github-페이지-블로그-만들기-with-Hugo](https://velog.io/@mellonggo/Github-%ED%8E%98%EC%9D%B4%EC%A7%80-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%A7%8C%EB%93%A4%EA%B8%B0-with-Hugo)

[https://gurumee92.github.io/2020/08/블로그-구축기-1-hugo-github으로-개인-블로그-만들기/](https://gurumee92.github.io/2020/08/%EB%B8%94%EB%A1%9C%EA%B7%B8-%EA%B5%AC%EC%B6%95%EA%B8%B0-1-hugo-github%EC%9C%BC%EB%A1%9C-%EA%B0%9C%EC%9D%B8-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%A7%8C%EB%93%A4%EA%B8%B0/)