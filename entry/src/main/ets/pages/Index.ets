@Entry
@Component
struct TimerPage {
  @State time: number = 0;
  @State isRunning: boolean = false;
  private timerId: number = -1;

  build() {
    Column() {
      // 时间显示
      Text(this.formatTime(this.time))
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 60, top: 100 })

      // 按钮组
      Row({ space: 30 }) {
        Button(this.isRunning ? "暂停" : "开始")
          .width(100)
          .height(50)
          .onClick(() => {
            this.toggleTimer();
          })

        Button("重置")
          .width(100)
          .height(50)
          .backgroundColor(Color.Grey)
          .onClick(() => {
            this.resetTimer();
          })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  // 开始/暂停
  toggleTimer() {
    if (this.isRunning) {
      clearInterval(this.timerId);
      this.isRunning = false;
    } else {
      this.timerId = setInterval(() => {
        this.time += 10;
      }, 10);
      this.isRunning = true;
    }
  }

  // 重置
  resetTimer() {
    clearInterval(this.timerId);
    this.time = 0;
    this.isRunning = false;
  }

  // 格式化时间 00:00:00.00
  formatTime(ms: number): string {
    let totalSeconds = Math.floor(ms / 1000);
    let hours = Math.floor(totalSeconds / 3600);
    let minutes = Math.floor((totalSeconds % 3600) / 60);
    let seconds = totalSeconds % 60;
    let millis = Math.floor((ms % 1000) / 10);

    return `${this.pad(hours)}:${this.pad(minutes)}:${this.pad(seconds)}.${this.pad(millis)}`;
  }

  pad(num: number): string {
    return num.toString().padStart(2, '0');
  }
}