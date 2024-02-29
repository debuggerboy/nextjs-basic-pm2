module.exports = {
  apps : [{
    name       : "pylot",
    script     : "./node_modules/.bin/next",
    args       : "start",
    instances  : "4",
    exec_mode  : "cluster"
  }]
}
