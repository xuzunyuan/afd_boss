var cateSelect = (function(){
	function cateSel() {
	};
	cateSel.prototype = { 
		ctx: undefined,
		
		// fc一级类目下拉列表元素ID,sc二级的,tc三级的
		init : function(ctx, fc, sc, tc) {
			cateSel.prototype.fc = "#"+(fc || "fc");
			cateSel.prototype.sc = "#"+(sc || "sc");
			cateSel.prototype.tc = "#"+(tc || "tc");
			 
			cateSel.prototype.ctx = ctx;
			
			this._fetchSubCategory(this.fc, 0);
			
			$(this.fc).change(function() {
				cateSel.prototype._fetchSubCategory(cateSel.prototype.sc, this.value);
			});
			$(this.sc).change(function() {
				cateSel.prototype._fetchSubCategory(cateSel.prototype.tc, this.value);
			});
		},
		
		_fetchSubCategory : function(elemId, pId) {
			if (pId == "-1") {
				$(this.tc).empty().append("<option value=\"-1\">请选择</option>");
				if (elemId == this.sc) {
					$(this.sc).empty().append("<option value=\"-1\">请选择</option>");
				}
			} else if (pId >= 0) {
				$.ajax({
					url : cateSel.prototype.ctx+"/category/noAuth/bc/pList",
					type : "GET",
					data : {
						pId : pId
					},
					async : false,
					success : function(list) {
						if (list != null && list.length > 0) {
							cateSel.prototype._appendOption(elemId, list);
						}
					}
				});
			}
		},
		_appendOption : function(elemId, objList) {
			var sel$ = $(elemId);
			sel$.empty();
			 
			if (this.sc === elemId) {
				$(this.tc).empty().append("<option value=\"-1\">请选择</option>");
			}

			sel$.append('<option value="-1">请选择</option>');
			$.each(objList, function() {
				sel$.append('<option value="' + this.bcId + '">' + this.bcName
						+ '</option>');
			});
		}

	};
	
	return new cateSel();
})();