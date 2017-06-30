"use strict";
var read = require('pngjs').PNG.sync.read;
exports.decodeImpl = function(left) {
    return function(right) {
	return function(ab) {
	    try {
		var im = read(Buffer(ab));
		im.data = im.data.buffer;
		return right(im);
	    } catch (e) {
		return left(e);
	    };
	};
    };
};
