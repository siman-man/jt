require "spec_helper"

RSpec.describe Jt do
  describe 'examples' do
    it 'test case 01' do
      json =<<-JSON
{
	"title": "Person",
	"type": "object",
	"properties": {
		"firstName": {
			"type": "string"
		},
		"lastName": {
			"type": "string"
		},
		"age": {
			"description": "Age in years",
			"type": "integer",
			"minimum": 0
		}
	},
	"required": ["firstName", "lastName"]
}
      JSON

      expect =<<-EXPECT
root
├──── "title": "Person"
├──── "type": "object"
├──── "properties"
│       ├──── "firstName"
│       │       └──── "type": "string"
│       ├──── "lastName"
│       │       └──── "type": "string"
│       └──── "age"
│               ├──── "description": "Age in years"
│               ├──── "type": "integer"
│               └──── "minimum": 0
└──── "required"
        ├──── "firstName"
        └──── "lastName"
      EXPECT

      expect(Jt.create(json).to_s.uncolorize).to eq(expect)
    end

    it 'test case 02' do
      json =<<-JSON
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {
        "/": {}
    },
    "patternProperties": {
        "^(/[^/]+)+$": {}
    },
    "additionalProperties": false,
    "required": [ "/" ]
}
      JSON

      expect =<<-EXPECT
root
├──── "$schema": "http://json-schema.org/draft-04/schema#"
├──── "type": "object"
├──── "properties"
│       └──── "/": {}
├──── "patternProperties"
│       └──── "^(/[^/]+)+$": {}
├──── "additionalProperties": false
└──── "required"
        └──── "/"
      EXPECT

      expect(Jt.create(json).to_s.uncolorize).to eq(expect)
    end

    it 'test case 03' do
      json =<<-JSON
 {
    "id": "http://some.site.somewhere/entry-schema#",
    "$schema": "http://json-schema.org/draft-04/schema#",
    "description": "schema for an fstab entry",
    "type": "object",
    "required": [ "storage" ],
    "properties": {
        "storage": {
            "type": "object",
            "oneOf": [
                { "$ref": "#/definitions/diskDevice" },
                { "$ref": "#/definitions/diskUUID" },
                { "$ref": "#/definitions/nfs" },
                { "$ref": "#/definitions/tmpfs" }
            ]
        }
    },
    "definitions": {
        "diskDevice": {},
        "diskUUID": {},
        "nfs": {},
        "tmpfs": {}
    }
}
      JSON

      expect =<<-EXPECT
root
├──── "id": "http://some.site.somewhere/entry-schema#"
├──── "$schema": "http://json-schema.org/draft-04/schema#"
├──── "description": "schema for an fstab entry"
├──── "type": "object"
├──── "required"
│       └──── "storage"
├──── "properties"
│       └──── "storage"
│               ├──── "type": "object"
│               └──── "oneOf"
│                       ├──── object
│                       │       └──── "$ref": "#/definitions/diskDevice"
│                       ├──── object
│                       │       └──── "$ref": "#/definitions/diskUUID"
│                       ├──── object
│                       │       └──── "$ref": "#/definitions/nfs"
│                       └──── object
│                               └──── "$ref": "#/definitions/tmpfs"
└──── "definitions"
        ├──── "diskDevice": {}
        ├──── "diskUUID": {}
        ├──── "nfs": {}
        └──── "tmpfs": {}
      EXPECT

      expect(Jt.create(json).to_s.uncolorize).to eq(expect)
    end
  end
end
