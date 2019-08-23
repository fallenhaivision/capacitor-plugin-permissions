import { WebPlugin } from '@capacitor/core';
import { PermissionsPlugin } from './definitions';

export class PermissionsWeb extends WebPlugin implements PermissionsPlugin {
  constructor() {
    super({
      name: 'Permissions',
      platforms: ['web']
    });
  }

  async echo(options: { value: string }): Promise<{value: string}> {
    console.log('ECHO', options);
    return options;
  }
}

const Permissions = new PermissionsWeb();

export { Permissions };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(Permissions);
