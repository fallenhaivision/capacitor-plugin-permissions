import { WebPlugin } from "@capacitor/core";
import { PermissionsPlugin } from "./definitions";

export class PermissionsWeb extends WebPlugin implements PermissionsPlugin {
  constructor() {
    super({
      name: "Permissions",
      platforms: ["web"]
    });
  }

  requestPermission = async (options: {
    permission: string;
  }): Promise<{ status: string }> => {
    return {
      status: options.permission
    };
  };

  getStatus = async (options: {
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
