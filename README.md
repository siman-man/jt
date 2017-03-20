# Jt

[![Build Status](https://travis-ci.org/siman-man/jt.svg?branch=master)](https://travis-ci.org/siman-man/jt)

tree command for json.

## Installation

```
$ gem install jt
```

## Usage

pass json data to jt command.

```
curl http://jsonplaceholder.typicode.com/users/1 | jt
```

output

```
root
├──── "id": 1
├──── "name": "Leanne Graham"
├──── "username": "Bret"
├──── "email": "Sincere@april.biz"
├──── "address"
│       ├──── "street": "Kulas Light"
│       ├──── "suite": "Apt. 556"
│       ├──── "city": "Gwenborough"
│       ├──── "zipcode": "92998-3874"
│       └──── "geo"
│               ├──── "lat": "-37.3159"
│               └──── "lng": "81.1496"
├──── "phone": "1-770-736-8031 x56442"
├──── "website": "hildegard.org"
└──── "company"
        ├──── "name": "Romaguera-Crona"
        ├──── "catchPhrase": "Multi-layered client-server neural-net"
        └──── "bs": "harness real-time e-markets"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/siman-man/jt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

