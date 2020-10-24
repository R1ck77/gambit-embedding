
(define gl-color-buffer-bit (uint-c-constant "GL_COLOR_BUFFER_BIT"))
(define gl-vertex-shader (uint-c-constant "GL_VERTEX_SHADER"))
(define gl-fragment-shader (uint-c-constant "GL_FRAGMENT_SHADER"))
(define gl-array-buffer (int-c-constant "GL_ARRAY_BUFFER"))

;; Booleans
(define gl-true (int-c-constant "GL_TRUE"))
(define gl-false (int-c-constant "GL_FALSE"))

;; Types
(define gl-byte (int-c-constant "GL_BYTE"))
(define gl-unsigned-byte (int-c-constant "GL_UNSIGNED_BYTE"))
(define gl-short (int-c-constant "GL_SHORT"))
(define gl-unsigned-short (int-c-constant "GL_UNSIGNED_SHORT"))
(define gl-int (int-c-constant "GL_INT"))
(define gl-unsigned-int (int-c-constant "GL_UNSIGNED_INT"))
(define gl-float (int-c-constant "GL_FLOAT"))
(define gl-fixed (int-c-constant "GL_FIXED"))
;(define gl-half-float (int-c-constant "GL_HALF_FLOAT"))
;(define gl-int-2-10-10-10-rev (int-c-constant "GL_INT_2_10_10_10_REV"))
;(define gl-unsigned-int-2-10-10-10-rev (int-c-constant "GL_UNSIGNED_INT_2_10_10_10_REV"))

;;; Primitives
(define gl-points (uint-c-constant "GL_POINTS"))
(define gl-line-strip (uint-c-constant "GL_LINE_STRIP"))
(define gl-line-loop (uint-c-constant "GL_LINE_LOOP"))
(define gl-lines (uint-c-constant "GL_LINES"))
(define gl-triangle-strip (uint-c-constant "GL_TRIANGLE_STRIP"))
(define gl-triangle-fan (uint-c-constant "GL_TRIANGLE_FAN"))
(define gl-triangles (uint-c-constant "GL_TRIANGLES"))

;; Error codes
(define gl-invalid-value (uint-c-constant "GL_INVALID_VALUE"))
(define gl-invalid-operation (uint-c-constant "GL_INVALID_OPERATION"))
(define gl-no-error (uint-c-constant "GL_NO_ERROR"))

;; glGetProgramiv/Shaderiv parameters
(define gl-active-attributes (uint-c-constant "GL_ACTIVE_ATTRIBUTES"))
(define gl-active-attribute-max-length (uint-c-constant "GL_ACTIVE_ATTRIBUTE_MAX_LENGTH"))
(define gl-active-uniforms (uint-c-constant "GL_ACTIVE_UNIFORMS"))
;;(define gl-active-uniform-blocks (uint-c-constant "GL_ACTIVE_UNIFORM_BLOCKS"))
;;(define gl-active-uniform-block-max-name-length (uint-c-constant "GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH"))
(define gl-active-uniform-max-length (uint-c-constant "GL_ACTIVE_UNIFORM_MAX_LENGTH"))
(define gl-attached-shaders (uint-c-constant "GL_ATTACHED_SHADERS"))
(define gl-delete-status (uint-c-constant "GL_DELETE_STATUS"))
(define gl-info-log-length (uint-c-constant "GL_INFO_LOG_LENGTH"))
(define gl-link-status (uint-c-constant "GL_LINK_STATUS"))
;;(define gl-program-binary-retrievable-hint (uint-c-constant "GL_PROGRAM_BINARY_RETRIEVABLE_HINT"))
;;(define gl-transform-feedback-buffer-mode (uint-c-constant "GL_TRANSFORM_FEEDBACK_BUFFER_MODE"))
;;(define gl-transform-feedback-varyings (uint-c-constant "GL_TRANSFORM_FEEDBACK_VARYINGS"))
;;(define gl-transform-feedback-varying-max-length (uint-c-constant "GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH"))
(define gl-validate-status (uint-c-constant "GL_VALIDATE_STATUS"))
(define gl-shader-type (uint-c-constant "GL_SHADER_TYPE"))
(define gl-compile-status (uint-c-constant "GL_COMPILE_STATUS"))
(define gl-shader-source-length (uint-c-constant "GL_SHADER_SOURCE_LENGTH"))
