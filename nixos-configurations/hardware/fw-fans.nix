
{inputs, ...} : {

imports = [
  inputs.fw-fanctrl.nixosModules.default
];
# Enable fw-fanctrl
programs.fw-fanctrl.enable = true;

# Add a custom config
programs.fw-fanctrl.config = {
  defaultStrategy = "silent";
  strategies = {
    "silent" = {
      fanSpeedUpdateFrequency = 2;
      movingAverageInterval = 10;
      speedCurve = [
        { temp = 45; speed = 0; }
        { temp = 60; speed = 25; }
        { temp = 70; speed = 35; }
        { temp = 80; speed = 80; }
        { temp = 85; speed = 100; }
      ];
    };
    "lazy" = {
      fanSpeedUpdateFrequency = 5;
      movingAverageInterval = 30;
      speedCurve = [
        { temp = 0; speed = 15; }
        { temp = 50; speed = 15; }
        { temp = 65; speed = 25; }
        { temp = 70; speed = 35; }
        { temp = 75; speed = 50; }
        { temp = 85; speed = 100; }
      ];
    };
  };
};
}
