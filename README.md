# confluence-space-download
## needed enviroment

| Key | Description |
|-----|-----|
| USRNAME | confluence-Username |
| USRPWD | confluence-Password |
| SPACE_KEY | Space-Key of the confluence space |
| CONFBASEURL | base-URL of confluence | 

## possible enviroment

| Key | Description |
|-----|-----|
| NOT_ROUTABLE_HOST | host, which is in the URL, but not routable | 
| ROUTABLE_HOST | host, replaces not routable host |

## example command complete
```docker
docker run --rm -v /tmp/export:/export/ -e USRNAME=user -e USRPWD=123 -e SPACE_KEY=SPACE -e CONFBASEURL=https://confluence.domain.com -e NOT_ROUTABLE_HOST=confluence -e ROUTABLE_HOST=confluence.domain.com kikkire/confluence-space-download
```

