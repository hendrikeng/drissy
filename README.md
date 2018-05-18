```
Install wirth:
composer create-project hendrikeng/drissy PROJEKTNAME -s RC

cd PROJEKTNAME
./craft setup

(automatic craft install doesnt work yet, install via browser : projekt.test/admin and import init_DB.sql afterwards)

cd PROJEKTNAME
./nys-setup

cd PROJEKTNAME
yarn dev:init

Start development with:
yarn dev:all

Start Build:
yarn build:all
```

All project relevant config (paths etc) is editable in ./build-config/common.config.js
