import common from '@ohos.app.ability.common';
import { FlutterPage } from '@ohos/flutter_ohos';

const EVENT_BACK_PRESS = 'EVENT_BACK_PRESS';

@Entry
@Component
struct Index {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  build() {
    // FlutterPage 会自动从 FlutterAbility 获取 viewId "oh_flutter_1"
    FlutterPage({ viewId: "oh_flutter_1" })
      .width('100%')
      .height('100%')
  }

  onBackPress(): boolean {
    this.context.eventHub.emit(EVENT_BACK_PRESS);
    return true;
  }
}