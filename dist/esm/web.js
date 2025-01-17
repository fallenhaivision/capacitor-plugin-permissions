var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { WebPlugin } from "@capacitor/core";
export class PermissionsWeb extends WebPlugin {
    constructor() {
        super({
            name: "Permissions",
            platforms: ["web"]
        });
        this.requestPhotoAndCameraPermission = (options) => __awaiter(this, void 0, void 0, function* () {
            return {
                status: options.permission
            };
        });
        this.requestPermission = (options) => __awaiter(this, void 0, void 0, function* () {
            return {
                status: options.permission
            };
        });
        this.checkStatus = (options) => __awaiter(this, void 0, void 0, function* () {
            return {
                status: options.permission
            };
        });
    }
}
const Permissions = new PermissionsWeb();
export { Permissions };
import { registerWebPlugin } from "@capacitor/core";
registerWebPlugin(Permissions);
//# sourceMappingURL=web.js.map