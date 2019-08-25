declare module "@capacitor/core" {
    interface PluginRegistry {
        Permissions: PermissionsPlugin;
    }
}
export declare const PERMISSIONS: {
    LOCATION_WHEN_IN_USE: string;
    LOCATION_ALWAYS: string;
    PHOTO_LIBRARY: string;
    CAMERA: string;
};
export interface PermissionsPlugin {
    requestPermission(options: {
        permission: string;
    }): Promise<{
        status: string;
    }>;
    checkStatus(options: {
        permission: string;
    }): Promise<{
        status: string;
    }>;
}
