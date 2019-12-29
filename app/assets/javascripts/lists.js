 $(function() {
    // The taskHtml method takes in a JavaScript representation
    // of the task and produces an HTML representation using
    // <li> tags
    function itemHtml(item) {
      var checkedStatus = item.done ? "checked" : "";
      var liClass = item.done ? "completed" : "";
       var liElement = '<li id="listItem-' + item.id +'" class="' + liClass + '">' +
    '<div class="view"><input class="toggle" type="checkbox"' +
      " data-id='" + item.id + "'" +
      checkedStatus +
      '><label>' +
       item.title +
       '</label></div></li>';

      return liElement;
    }

    // toggleTask takes in an HTML representation of the
    // an event that fires from an HTML representation of
    // the toggle checkbox and  performs an API request to toggle
    // the value of the `done` field
    function toggleItem(e) {
      var itemId = $(e.target).data("id");

      var doneValue = Boolean($(e.target).is(':checked'));

      $.post("/lists/" + itemId, {
        _method: "PUT",
        item: {
          done: doneValue
        }
      }).success(function(data) {
        var liHtml = itemHtml(data);
        var $li = $("#listItem-" + data.id);
        $li.replaceWith(liHtml);
        $('.toggle').change(toggleItem);
      } );
    }

    $.get("/lists").success( function( data ) {
      var htmlString = "";

      $.each(data, function(index,  item) {
        htmlString += itemHtml(item);
      });
      var ulTodos = $('.todo-list');
      ulTodos.html(htmlString);

      $('.toggle').change(toggleItem);

    });


    $('#new-form').submit(function(event) {
      event.preventDefault();
      var textbox = $('.new-todo');
      var payload = {
        item: {
          title: textbox.val()
        }
      };
      $.post("/lists", payload).success(function(data) {
        var htmlString = itemHtml(data);
        var ulTodos = $('.todo-list');
        ulTodos.append(htmlString);
        $('.toggle').click(toggleItem);
        $('.new-todo').val('');
      });
    });

  });