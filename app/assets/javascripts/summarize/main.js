// Avoid `console` errors in browsers that lack a console.
if (!(window.console && console.log)) {
	(function() {
		var noop = function() {};
		var methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'markTimeline', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
		var length = methods.length;
		var console = window.console = {};
		while (length--) {
			console[methods[length]] = noop;
		}
	}());
}


(function ($) {
	"use strict";

	$(function(){

		$(window).scroll(function() {
			var top = $(window).scrollTop();
			
			if ( top > ( $('#header').height() ) ) {
				$('body').addClass('scrolled');
			} else {
				$('body').removeClass('scrolled');
			}

		});

		$(document)
		.on('click', function(e) {

			if ( $(this).is( '[data-toggle]' ) === false ) {
				$('[data-toggled]').each(function(e) {

					if ( $(this).hasClass( $(this).attr('data-toggled') ) ) {
						$(this).toggleClass( $(this).attr('data-toggled') );
						$(this).removeAttr('data-toggled');
					}
				});
			}

		})
		.on('click', '[data-toggle][href="#"]', function(e) {
			e.stopPropagation();
			e.preventDefault();

			var $target = $(this).closest( $(this).data('toggle') ),
			class_name = ( $(this).data('toggle-class') ) ? $(this).data('toggle-class') : 'toggled-in';

			$target.toggleClass( class_name );

			if ( $target.hasClass( class_name ) ) {
				$target.attr('data-toggled', class_name );
				var $input = $target.find('input');
				
				if ( $input.size() > 0 ) {
					$input[0].focus();
				}
			} else {
				$target.removeAttr('data-toggled');
			}

			if ( $( '.subnav-tabbed-panel:first', $target ).size() > 0 ) {
				$( '.subnav-tabbed-panel:first img[data-src]', $target ).unveil();
			}

			var $siblings = $target.siblings('.' + class_name );

			$siblings.find( '.' +class_name ).toggleClass(class_name).removeAttr('data-toggled');
			$siblings.toggleClass( class_name ).removeAttr( 'data-toggled' );

		})

		.on('mouseover', '[data-toggle][href="#"]', function(e) {
			var $target = $(this).closest( $(this).data('toggle') ),
			class_name = ( $(this).data('toggle-class') ) ? $(this).data('toggle-class') : 'toggled-in',
			$siblings = $target.siblings('.' + class_name );

			$siblings.find( '.' +class_name ).toggleClass(class_name).removeAttr('data-toggled');
			$siblings.toggleClass( class_name ).removeAttr( 'data-toggled' );
		})

		.on( 'click', '.js-stoppropagation', function(e) {
			e.stopPropagation();
		})

		.on('click', '.js .collapsible-widgets .widget-title', function(e) {
			if ( $(this).closest('.widget').hasClass('active') ) {
				$(this).closest('.widget').removeClass('active');
			} else {
				$(this).closest('.widget').addClass('active').siblings().removeClass('active');
			}
			
			$(window).trigger('scroll');
		})
		.on('mouseover', '.subnav-tabbed-tabs a', function(e) {
			e.preventDefault();
			$(this).closest('li').addClass('active').siblings().removeClass('active');
			$( $(this).attr('href') ).addClass('active').siblings().removeClass('active');

			$('img[data-src]', $(this).attr('href') ).unveil();

		})
		.on('mouseover', '.full-subnav-wrapper', function(e) {

			if ( $( '.subnav-tabbed-panel:first', $(this) ).size() > 0 ) {
				$( '.subnav-tabbed-panel:first img[data-src]', $(this) ).unveil();
			}

		})
		.on('click', '.nav-tabs a', function (e) {
			e.preventDefault();
			$(this).tab('show');
		});

		$('.js .collapsible-widgets .widget:first .widget-title').trigger('click');

		$('#brand img[data-src]').unveil();

		$('#main img[data-src]').unveil(200, function() {
			$(this).load(function() {
				this.style.opacity = 1;
			});
		});

		$(window).trigger('scroll');

		$('.carousel').carousel();
		
		$('a[data-rel^="prettyPhoto"]').each(function () {

			$(this).attr('rel', $(this).data('rel') );

		});

		$("a[rel^='prettyPhoto']").prettyPhoto({
			animation_speed: 'fast', /* fast/slow/normal */
			slideshow: 5000, /* false OR interval time in ms */
			autoplay_slideshow: false, /* true/false */
			opacity: 0.80, /* Value between 0 and 1 */
			show_title: true, /* true/false */
			allow_resize: true, /* Resize the photos bigger than viewport. true/false */
			default_width: 500,
			default_height: 344,
			counter_separator_label: '/', /* The separator for the gallery counter 1 "of" 2 */
			theme: 'dark_square', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
			horizontal_padding: 5, /* The padding on each side of the picture */
			hideflash: false, /* Hides all the flash object on a page, set to TRUE if flash appears over prettyPhoto */
			wmode: 'opaque', /* Set the flash wmode attribute */
			autoplay: true, /* Automatically start videos: True/False */
			modal: false, /* If set to true, only the close button will close the window */
			deeplinking: true, /* Allow prettyPhoto to update the url to enable deeplinking. */
			overlay_gallery: true, /* If set to true, a gallery will overlay the fullscreen image on mouse over */
			keyboard_shortcuts: true, /* Set to false if you open forms inside prettyPhoto */
			changepicturecallback: function(){}, /* Called everytime an item is shown/changed */
			callback: function(){}, /* Called when prettyPhoto is closed */
			ie6_fallback: true,
			markup: '<div class="pp_pic_holder"> \
						<div class="ppt">&nbsp;</div> \
						<div class="pp_top"> \
							<div class="pp_left"></div> \
							<div class="pp_middle"></div> \
							<div class="pp_right"></div> \
						</div> \
						<div class="pp_content_container"> \
							<div class="pp_left"> \
							<div class="pp_right"> \
								<div class="pp_content"> \
									<div class="pp_loaderIcon"></div> \
									<div class="pp_fade"> \
										<div class="pp_topHoverContainer"> \
										<a href="#" class="pp_expand" title="Expand the image"><i class="icon-fullscreen"></i></a> \
										<a class="pp_close" href="#"><i class="icon-remove"></i></a> \
										</div> \
										<div class="pp_hoverContainer"> \
											<a class="pp_next" href="#"><span><i class="icon-chevron-right"></i></span></a> \
											<a class="pp_previous" href="#"><span><i class="icon-chevron-left"></i></span></a> \
										</div> \
										<div id="pp_full_res"></div> \
										<div class="pp_details"> \
											<p class="pp_description"></p> \
										</div> \
									</div> \
								</div> \
							</div> \
							</div> \
						</div> \
						<div class="pp_bottom"> \
							<div class="pp_left"></div> \
							<div class="pp_middle"></div> \
							<div class="pp_right"></div> \
						</div> \
					</div> \
					<div class="pp_overlay"></div>',
			gallery_markup: '<div class="pp_gallery"> \
								<a href="#" class="pp_arrow_previous">Previous</a> \
								<div> \
									<ul> \
										{gallery} \
									</ul> \
								</div> \
								<a href="#" class="pp_arrow_next">Next</a> \
							</div>',
			image_markup: '<img id="fullResImage" src="{path}" />',
			flash_markup: '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="{width}" height="{height}"><param name="wmode" value="{wmode}" /><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="{path}" /><embed src="{path}" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="{width}" height="{height}" wmode="{wmode}"></embed></object>',
			quicktime_markup: '<object classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" codebase="http://www.apple.com/qtactivex/qtplugin.cab" height="{height}" width="{width}"><param name="src" value="{path}"><param name="autoplay" value="{autoplay}"><param name="type" value="video/quicktime"><embed src="{path}" height="{height}" width="{width}" autoplay="{autoplay}" type="video/quicktime" pluginspage="http://www.apple.com/quicktime/download/"></embed></object>',
			iframe_markup: '<iframe src ="{path}" width="{width}" height="{height}" frameborder="no"></iframe>',
			inline_markup: '<div class="pp_inline">{content}</div>',
			custom_markup: '',
			social_tools: '<div class="pp_social"><div class="twitter"><a href="http://twitter.com/share" class="twitter-share-button" data-count="none">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></div><div class="facebook"><iframe src="http://www.facebook.com/plugins/like.php?locale=en_US&href='+location.href+'&amp;layout=button_count&amp;show_faces=true&amp;width=500&amp;action=like&amp;font&amp;colorscheme=light&amp;height=23" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:500px; height:23px;" allowTransparency="true"></iframe></div></div>' /* html or false to disable */
		});

	});

})(window.jQuery);