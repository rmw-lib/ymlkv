import fs from 'fs-extra'
import yaml from 'js-yaml'
import isEqual from 'lodash/isEqual'

class YamlDb
  constructor:(@file)->
    @_ = yaml.load(@yml()) or {}

  get:(key)->
    @_[key]

  yml:->
    {file} = @
    if fs.existsSync file
      return fs.readFileSync file
    ""

  set:(key, val)->
    _set = (k,v)=>
      exist = k of @_
      if exist
        old = @_[k]
        w = isEqual old,v
      else
        w = true
      if w
        @_[k] = v
      return (w or false)

    if key.constructor == Object
      write = false
      for i, val of key
        write |= _set(i,val)
    else
      write = _set key,val
    if write
      fs.outputFileSync @file, yaml.dump(@_)
    return write

export default (file)->
  new YamlDb(file)

