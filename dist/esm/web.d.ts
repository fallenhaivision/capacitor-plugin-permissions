import { WebPlugin } from "@capacitor/core";
import { PermissionsPlugin } from "./definitions";
export declare class PermissionsWeb extends WebPlugin implements PermissionsPlugin {
    constructor();
    requestPermission: (options: {
        permission: string;
    }) => Promise<{
        status: string;
    }>;
    getStatus: (options: {
        permission: string;
    }) => Promise<{
        status: string;
    }>;
}
declare const Permissions: PermissionsWeb;
export { Permissions };
