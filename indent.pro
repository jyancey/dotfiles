/*(@)#indent.pro - Format setting for indent.
 *
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * You can obtain a copy of the license in  the LICENSE file
 * or https://opensource.org/license/cddl-1-0/
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 *
 * Copyright (c) 2023 John Yancey <john.w.yancey@gmail.com>
 *
 */
-bap    /* Force blank lines after procedure bodies. */
-bbo    /* Prefer to break long lines before boolean operators. */
-blf    /* Put braces on line following function definition line */
-br     /* Put braces on line with if, etc. */
-brs    /* Put braces on struct declaration line. */
-cdw    /* Cuddle while with } in a do-while loop. */ 
-ce     /* Cuddle } and else. */
-ci4    /* Continuation indent of 4 spaces. */
-cli4   /* Case label indent of 4 spaces. */
-cbi0   /* Indent the braces below a case statement. */
-cp33   /* Put comments to the right of #else and #endif statements in column 33. */
-d0     /* Set indentation of comments not to the right of code to 0 spaces. */
-di2    /* Put variables in column 2. */
-fca    /* Do not disable all formatting of comments. */
-hnl    /* Prefer to break long lines at the position of newlines in the input. */
-i4     /* Set indentation level to 4 spaces. */
-il 1   /* Set offset for labels to column 0. */
-ip0    /* Indent parameter types in old-style function definitions by 0 spaces. */
-l80    /* Set maximum line length for non-comment lines to 80. */
-lp     /* Line up continued lines at parentheses. */
-nbad   /* Do not force blank lines after declarations. */
-nbc    /* Do not force newlines after commas in declarations. */
-ncdb   /* Do not put comment delimiters on blank lines. */
-ncs    /* Do not put a space after cast operators. */
-nfc1   /* Do not format comments in the first column as normal. */
-nfca   /* Do not format any comments. */
-npcs   /* Do not put space after the function in function calls. */
-nprs   /* Do not put a space after every '(' and before every ')'. */
-nsc    /* Do not put the ‘*’ character at the left of comments. */
-nut    /* Use spaces instead of tabs. */
-psl    /* Put the type of a procedure on the line before its name. */
-saf    /* Put a space after each for. */
-sai    /* Put a space after each if. */
-saw    /* Put a space after each while. */
-sob    /* Swallow optional blank lines. */
-ss     /* On one-line for and while statements, force a blank before the semicolon. */
-ts4    /* Set tab size to 4 spaces. */
