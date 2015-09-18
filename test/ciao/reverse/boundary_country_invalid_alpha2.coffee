
#> bounding country
path: '/v1/reverse?point.lat=1&point.lon=1&boundary.country=ZZ'

#? 200 ok
response.statusCode.should.be.equal 200
response.should.have.header 'charset', 'utf8'
response.should.have.header 'content-type', 'application/json; charset=utf-8'

#? valid geocoding block
should.exist json.geocoding
should.exist json.geocoding.version
should.exist json.geocoding.attribution
should.exist json.geocoding.query
should.exist json.geocoding.engine
should.exist json.geocoding.engine.name
should.exist json.geocoding.engine.author
should.exist json.geocoding.engine.version
should.exist json.geocoding.timestamp

#? valid geojson
json.type.should.be.equal 'FeatureCollection'
json.features.should.be.instanceof Array

#? expected errors
should.exist json.geocoding.errors
json.geocoding.errors.should.eql [ 'ZZ is not a valid ISO2/ISO3 country code' ]

#? expected warnings
should.not.exist json.geocoding.warnings

#? inputs
json.geocoding.query['size'].should.eql 10
should.not.exist json.geocoding.query['boundary.country']