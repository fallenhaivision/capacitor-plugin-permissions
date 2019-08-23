declare module "@capacitor/core" {
  interface PluginRegistry {
    Permissions: PermissionsPlugin;
  }
}

export const PERMISSIONS = {
  LOCATION_WHEN_IN_USE: "LOCATION_WHEN_IN_USE",
  LOCATION_ALWAYS: "LOCATION_ALWAYS",
  PHOTO_LIBRARY: "PHOTO_LIBRARY",
  CAMERA: "CAMERA"
};

export interface PermissionsPlugin {
  request(permission: string): Promise<{ status: string }>;
}
