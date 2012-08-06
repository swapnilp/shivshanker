var module = angular.module("global.directives", []);

module.directive("csrfTokenized", function() {
  function authenticityToken() {
    return $("meta[name='csrf-token']").attr("content") || "0xDEADBEEF";
  }

  return {
    restrict: "A",
    link: function(scope, elt, attrs, controller) {
      var tag = $("<input/>").attr("type", "hidden");
      tag.attr("name", "authenticity_token");
      tag.attr("value", authenticityToken());
      $(elt).prepend(tag);
    }
  }
})

module.directive("uiModal", ["$timeout", function($timeout) {
  return {
    restrict: "EAC",
    require: "ngModel",
    link: function(scope, elm, attrs, model) {
      //helper so you don"t have to type class="modal hide"
      elm.addClass("modal hide");
      scope.$watch(attrs.ngModel, function(value) {
        elm.modal(value && "show" || "hide");
      });

      elm.on("show.ui", function() {
        $timeout(function() {
          model.$setViewValue(true);
        });
      });
      
      elm.on("hide.ui", function() {
        $timeout(function() {
          model.$setViewValue(false);
        });
      });
    }
  };
}]);

module.directive("viewTabs", function() {
  return {
    restrict: "AC",
    scope: {},
    controller: ["$scope", "$element", "$location", function($scope, $element, $location) {
      var links = [];
      var activeTab = $location.path().substring(1, $location.path().length);
      
      function setActive(title) {
        angular.forEach(links, function(v) {
          if (v.attr("title") == title) {
            v.addClass("active");
          } else {
            v.removeClass("active");
          }
        });
      };

      this.addLink = function (elm, attrs) {
        links.push(elm);

        if (activeTab == elm.attr("title")) {
          setActive(activeTab);
        }
        
        elm.bind("click", function(event) {
          setActive(elm.attr("title"));
        });
      };
    }],
    link: function(scope, elm, attrs, controller) {
    }
  };
});

module.directive("viewTabLink", function() {
  return {
    require: '^viewTabs',
    restrict: 'AC',
    link: function(scope, element, attrs, tabsCtrl) {
      tabsCtrl.addLink(element, attrs);
    }
  };
});