s = "set-cookie: remix_userkey=988d277f26e42c6b5f8a9b171ea0dc31; expires=Tue, 06-Feb-2024 18:05:55 GMT; Max-Age=3600000; path=/; domain=z-library.se"

s = s.match(/remix_userkey=[a-z|0-9]+;/)[0]
console.log(s)