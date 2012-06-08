[//lasso

	// This file displays the Knop quick reference generated by ->help. 
	
	// Created by Jason Huck 2008-06-02
	
	/*

	2008-12-09	JS	Changed jQuery link to Googleapi as cachefile.net is closing down
	
	*/

	// handle AJAX requests
	if(action_param('q'));
		var(
			'q' = action_param('q'),
			'response' = string
		);
	
		protect;
			// create a dummy object to extract the help contents
			select($q);
				case('knop_base');
					var('o') = knop_base;
				case('knop_database');
					var('o') = knop_database(
						-database='site',
						-table='sessions'
					);
				case('knop_form');
					var('o') = knop_form;
				case('knop_grid');
					var('o') = knop_grid(
						-database=knop_database(
							-database='site',
							-table='sessions'
						)
					);
				case('knop_lang');
					var('o') = knop_lang;
				case('knop_nav');
					var('o') = knop_nav;
				case('knop_user');
					var('o') = knop_user(
						-userdb=knop_database(
							-database='lasso_internal',
							-table='security_users'
						)
					);
			/select;
		
			// add a header
			$response = '<h2>' + $q + '</h2>\n' + $o->help( -html);

			// add some rudimentary hooks for the CSS			
			$response = string_replaceregexp(
				$response,
				-find='\\n(-&gt;\\s*.*)<br ?/?>',
				-replace='<h3 class="member">\\1</h3>',
				-ignorecase
			);

			$response = string_replaceregexp(
				$response,
				-find='\\n(-\\w+)\\s',
				-replace='<span class="param">\\1</span> ',
				-ignorecase
			);

			$response = string_replaceregexp(
				$response,
				-find='(\\(required[^\\)]*\\))',
				-replace='<span class="req">\\1</span> ',
				-ignorecase
			);

			$response = string_replaceregexp(
				$response,
				-find='(\\(optional[^\\)]*\\))',
				-replace='<span class="opt">\\1</span> ',
				-ignorecase
			);
			
			if(lasso_tagexists('knop_changenotes'));
				var('changenotes'=encode_break(knop_changenotes($q)));
				$response += '<h2 class="changenotes">Change notes</h2><p class="changenotes">' + $changenotes + '</p>';
			/if;
			
			handle_error;
				$response = error_msg;
			/handle_error;
		/protect;

		// send the result back to the client		
		$__html_reply__ = $response;
		abort;
	/if;

	// load Knop if necessary
	/*if(!lasso_tagexists('knop_base'));
		namespace_using(namespace_global);
			library('/to LassoLibraries/knop.lasso');
		/namespace_using;
	/if;*/

	// generate navigation	
	var('types') = array(
		'base', 'database', 'form',
		'grid', 'lang', 'nav', 'user'
	);
	
	var('nav') = string;
	
	iterate($types, local('i'));
		$nav += '\t\t\t<li>knop_' + #i + '</li>\n';
	/iterate;	
]
<html>
	<head>
		<title>Knop API</title>
		<style type="text/css">
		* {
			font-family: lucida sans, arial, sans-serif;
			font-size: 12px;
			margin: 0;
			padding: 0;
		}
		
		body { 
			margin: 50px;
		}
		
		h1 { 
			font-size: 16px;
		}
		
		h2 { 
			color: #039;
			font-size: 14px;
		}
		h3 { 
			font-size: 13px;
		}
				
		#nav {
			display: block;
			float: left;
			width: 100px;
			border-top: 1px dotted #ccc;
			top: 100px;
		}		
		
		h1, #nav { 
			position: fixed;
		}		
		
		#nav li {
			color: #039;
			display: block;
			padding-top: 2px;
			padding-bottom: 5px;
			border-bottom: 1px dotted #ccc;
		}		
		
		#nav li:hover,
		#nav li.on {
			cursor: pointer;
			background-color: #eee;
		}		
		
		#nav li.on { 
			font-weight: bold;
		}		
		
		#text {
			color: #666;
			padding-left: 125px;
		}

		.member, .param {
			font-weight: bold;		
		}
				
		.member {
			color: #039;
		}
		
		.param {
			color: #090;
			padding-left: 50px;
		}
		
		.req, .opt {
			font-style: italic;		
		}
		
		.req {
			color: red;
		}
		</style>
		<script 
			type="text/javascript" 
			src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js">
		</script>
		<script type="text/javascript">
		$(function(){
			$('#nav li').click(function(){
				$('#nav li').removeClass('on');
				$(this).addClass('on');
				$('#text').load('[response_filepath]?q=' + $(this).text());
			});
		});
		</script>
	</head>
	<body>
		<h1>Knop API</h1>
		<ul id="nav">
[$nav]
		</ul>
		<div id="text">Select an item from the list on the left.</div>
	</body>
</html>
