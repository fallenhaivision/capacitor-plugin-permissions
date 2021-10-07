import { WebPlugin } from "@capacitor/core";
import { PermissionsPlugin } from "./definitions";
export declare class PermissionsWeb extends WebPlugin implements PermissionsPlugin {
    constructor();
    requestPhotoAndCameraPermission: (options: {
        permission: string;
    }) => Promise<{
        status: string;
    }>;
    requestPermission: (options: {
        permission: string;
    }) => Promise<{
        status: string;
    }>;
    checkStatus: (options: {
        permission: string;
    }) => Promise<{
        status: string;
    }>;
}
declare const Permissions: PermissionsWeb;
export { Permissions };
