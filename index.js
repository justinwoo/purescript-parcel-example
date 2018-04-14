import React from "react";
import ReactDOM from "react-dom";

import Main from "./output/Main";

function main() {
  const myComponent = React.createElement(Main.example, { label: "Increment" });

  ReactDOM.render(myComponent, document.getElementById("app"));
}

if (module.hot) {
  module.hot.accept(function() {
    console.log("running main again");
    main();
  });
}

console.log("starting");
main();
