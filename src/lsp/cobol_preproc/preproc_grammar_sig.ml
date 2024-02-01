(**************************************************************************)
(*                                                                        *)
(*                        SuperBOL OSS Studio                             *)
(*                                                                        *)
(*  Copyright (c) 2022-2023 OCamlPro SAS                                  *)
(*                                                                        *)
(* All rights reserved.                                                   *)
(* This source code is licensed under the GNU Affero General Public       *)
(* License version 3 found in the LICENSE.md file in the root directory   *)
(* of this source tree.                                                   *)
(*                                                                        *)
(**************************************************************************)

(* Interface of the module generated by preproc_grammar.mly *)

module type S = sig
  (* From _build/default/src/cobol_preproc/preproc_grammar.mli *)

  module Make
      (CONFIG: Cobol_config.Types.T)
      (Overlay_manager: Src_overlay.MANAGER)
    : sig

      (* The type of tokens. *)

      type token = Preproc_tokens.token

      (* This exception is raised by the monolithic API functions. *)

      exception Error

      (* The monolithic API. *)

      val replace_statement: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Preproc_directives.replace_statement Cobol_common.Srcloc.with_loc)

      val copy_statement: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Preproc_directives.copy_statement Cobol_common.Srcloc.with_loc)

      val _unused_symbols: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit)

      module MenhirInterpreter : sig

        (* The incremental API. *)

        include MenhirLib.IncrementalEngine.INCREMENTAL_ENGINE
          with type token = token

      end

      (* The entry point(s) to the incremental API. *)

      module Incremental : sig

        val replace_statement: Lexing.position -> (Preproc_directives.replace_statement Cobol_common.Srcloc.with_loc) MenhirInterpreter.checkpoint

        val copy_statement: Lexing.position -> (Preproc_directives.copy_statement Cobol_common.Srcloc.with_loc) MenhirInterpreter.checkpoint

        val _unused_symbols: Lexing.position -> (unit) MenhirInterpreter.checkpoint

      end

    end

end
