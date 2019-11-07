
import { } from "./src/AppModule/components/GlobalConstant";
import { RypYo, AppType } from "react-native-ecpei-framework";
import apiConfig from "./src/AppModule/config/apiConfig";
import appConfig from "./src/AppModule/config/appConfig";
import baseVariables from './src/AppModule/themes/base-theme'
import getTheme from './src/AppModule/themes/components';
import { RootSaga } from "./src/AppModule";
import { RypTheme, ServiceTheme, ServiceVariables, SupplierVariables, SupplierTheme } from "react-native-ecpei-widgets";
import {
    AppSupReducers,
    AppSerReducers,
    AppModuleServer,
    AppModuleSupplier
} from "./src/AppModule";


//修改这个变量改变 App状态;
RypYo.initConfig({
    appConfig: appConfig(),  
    apiConfig: apiConfig(),
    reducerData: AppSerReducers,
    getTheme: RypTheme.integrationTheme(getTheme, SupplierTheme),
    theme: RypTheme.integrationVariables(baseVariables, SupplierVariables),
    reduxMiddleware: [],
    rootSage: RootSaga,
    appType: AppType.Server,
});
RypYo.registerBoots("com.ryp.rn.core", AppModuleServer)



