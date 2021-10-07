import { WebPlugin } from "@capacitor/core";
import { PermissionsPlugin } from "./definitions";

export class PermissionsWeb extends WebPlugin implements PermissionsPlugin {
  constructor() {
    super({
      name: "Permissions",
      platforms: ["web"]
    });
  }

  requestPhotoAndCameraPermission = async (options: {
    permission: string;
  }): Promise<{ status: string }> => {
    return {
      status: options.permission
    };
  };

  requestPermission = async (options: {
    permission: string;
  }): Promise<{ status: string }> => {
    return {
      status: options.permission
    };
  };

  checkStatus = async (options: {
    permission: string;
  }): Promise<{ status: string }> => {
    return {
      status: options.permission
    };
  };
}

const Permissions = new PermissionsWeb();

export { Permissions };

import { registerWebPlugin } from "@capacitor/core";
registerWebPlugin(Permissions);
