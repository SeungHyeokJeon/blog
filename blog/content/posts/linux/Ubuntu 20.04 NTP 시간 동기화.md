---
title: "Ubuntu 20.04 NTP 시간 동기화"
date: 2022-03-19
categories: ["linux"]
tags: ["ubuntu", "ntp", "server", "timezone"]
cover: "/sources/linux/20220319_Ubuntu20.04NTP시간동기화/tiemzone_change.png"
draft: false
---

파일 백업용 서버를 운용하던 중, 파일 업로드 및 수정 시간이 엉뚱한 시간으로 나오는 것을 발견했고, Timezone 변경 및 NTP 동기화를 통해 정상적으로 시간이 출력되도록 하겠습니다.


## Timezone 변경

NTP를 통해 시간 대역을 맞추기 전, UTC가 기본으로 잡혀있는 timezone을 KST로 변경합니다.

```bash
sudo timedatectl set-timezone Asia/Seoul
```

![setting_check](/sources/linux/20220319_Ubuntu20.04NTP시간동기화/setting_check.png)

## NTP(Network Time Protocol)

### 설치

```bash
$ sudo apt-get install ntp
```

### 설정 변경

먼저 서버 설정 파일을 열어 ntp pool server를 변경해줍니다.

```bash
$ sudo vi /etc/ntp.conf
```

```bash
# /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help

...

# Specify one or more NTP servers.

# Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
# on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
# more information.
#pool 0.ubuntu.pool.ntp.org iburst        # 주석처리
#pool 1.ubuntu.pool.ntp.org iburst        # 주석처리
#pool 2.ubuntu.pool.ntp.org iburst        # 주석처리
#pool 3.ubuntu.pool.ntp.org iburst        # 주석처리
server 0.kr.pool.ntp.org iburst           # 신규
server time.google.com iburst             # 신규
server time.bora.net iburst               # 신규

# Use Ubuntu's ntp server as a fallback.
#pool ntp.ubuntu.com                      # 주석처리
...
```

여기서 iburst 옵션은 local server와 동기화 server간의 시간 차이와 무관하게 바로 동기화를 실행하는 옵션입니다.

iburst옵션을 지정하지 않으면 10분 이상 차이가 나야 동기화를 진행합니다.

### 설정 확인

설정을 모두 마쳤다면 아래 명령어를 입력하여 ntp 서비스를 재시작합니다.

```bash
$ sudo systemctl restart ntp
```

아래 명령어를 사용하여 ntp 동기화 상태를 확인하고, 서버의 시간이 제대로 동기화 되었는지 확인할 수 있습니다.

```bash
$ ntpq -p    # 시간 대역 동기화 상태 확인
$ date       # 시스템 날짜 확인
```

![tiemzone_change](/sources/linux/20220319_Ubuntu20.04NTP시간동기화/tiemzone_change.png)

### Reference

[https://velog.io/@johoon815/Ubuntu-20.04-우분투-NTP-시간-동기화-설정](https://velog.io/@johoon815/Ubuntu-20.04-%EC%9A%B0%EB%B6%84%ED%88%AC-NTP-%EC%8B%9C%EA%B0%84-%EB%8F%99%EA%B8%B0%ED%99%94-%EC%84%A4%EC%A0%95)

[https://webdir.tistory.com/208](https://webdir.tistory.com/208)

[https://www.pool.ntp.org/ko/zone/kr](https://www.pool.ntp.org/ko/zone/kr)

[https://zetawiki.com/wiki/공용_NTP_서버_목록](https://zetawiki.com/wiki/%EA%B3%B5%EC%9A%A9_NTP_%EC%84%9C%EB%B2%84_%EB%AA%A9%EB%A1%9D)