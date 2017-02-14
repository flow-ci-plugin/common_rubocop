# rubocop_plugin Step
A Ruby static code analyzer, based on the community Ruby style guide.

### INPUTS

* `FLOW_FIR_API_TOKEN` - fir.im api token.
* `FLOW_FIR_CHANGELOG` - changelog.
* `FLOW_FIR_APP_PATH` - app absolute path.


## EXAMPLE 

```yml
steps:
  - name: rubocop_plugin
    enable: true
    failure: true
    plugin:
      name: rubocop_plugin
      inputs:
```
