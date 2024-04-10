<#import "template.ftl" as layout>

<div class="flex flex-col h-screen items-center justify-center">

    <@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
        <#if section = "header">
            <span class="text-left font-Jakarta text-xl font-semibold">
                ${msg("loginAccountTitle")}
            </span>
            
        <#elseif section = "form">
            <div id="kc-form" >
            <div id="kc-form-wrapper" >
                <#if realm.password>
                    <form
                        id="kc-form-login"
                        onsubmit="login.disabled = true; return true;"
                        action="${url.loginAction}"
                        method="post">
                        <#if !usernameHidden??>
                            <div class="flex flex-col mb-4">
                                <label
                                    for="username"
                                    class="font-Jakarta font-medium text-sm"
                                >
                                    ${msg("email")}
                                </label>
                                <input
                                    tabindex="2"
                                    id="username"
                                    class="font-Jakarta rounded-md border border-gray-200 bg-white py-2 px-3 h-9"
                                    name="username"
                                    value="${(login.username!'')}"
                                    type="text"
                                    autofocus
                                    autocomplete="username"
                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />

                                <#if messagesPerField.existsError('username','password')>
                                    <span
                                        id="input-error"
                                        class="${properties.kcInputErrorMessageClass!}"
                                        aria-live="polite"
                                    >
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                    </span>
                                </#if>

                            </div>
                        </#if>
                        <div class="flex flex-col">
                            <label
                                for="username"
                                class="font-Jakarta font-medium text-sm"
                            >
                                ${msg("password")}
                            </label>

                            <div class="relative">
                                <input
                                    tabindex="3"
                                    id="password"
                                    class="font-Jakarta rounded-md border border-gray-200 py-2 pl-2 pr-7 h-9 w-full "
                                    name="password"
                                    type="password"
                                    autocomplete="current-password"
                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />
                                <#--  <i class="${properties.kcFormPasswordVisibilityIconShow!} absolute" aria-hidden="true"></i>  -->
                                <button
                                    class="absolute right-2 h-9 w-5"
                                    type="button"
                                    aria-label="${msg("showPassword")}"
                                    aria-controls="password"
                                    data-password-toggle
                                    tabindex="4"
                                    data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}"
                                    data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                    data-label-show="${msg('showPassword')}"
                                    data-label-hide="${msg('hidePassword')}"
                                >
                                    <i
                                        class="${properties.kcFormPasswordVisibilityIconShow!}"
                                        aria-hidden="true"
                                    >
                                    </i>
                                </button>
                            </div>

                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                <span
                                    id="input-error"
                                    class="${properties.kcInputErrorMessageClass!}"
                                    aria-live="polite"
                                >
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                            </#if>

                        </div>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                            <div id="kc-form-options">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <div class="checkbox">
                                        <label class="font-Jakarta text-sm">
                                            <#if login.rememberMe??>
                                                <input
                                                    tabindex="5"
                                                    id="rememberMe"
                                                    name="rememberMe"
                                                    type="checkbox"
                                                    checked
                                                >
                                                    ${msg("rememberMe")}
                                            <#else>
                                                <input
                                                    tabindex="5"
                                                    id="rememberMe"
                                                    name="rememberMe"
                                                    type="checkbox"
                                                >
                                                    ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                            </div>
                                <#--  <div class="${properties.kcFormOptionsWrapperClass!}">
                                    <#if realm.resetPasswordAllowed>
                                        <span class="font-bold">
                                            <a
                                                class="no-underline hover:no-underline"
                                                tabindex="6"
                                                href="${url.loginResetCredentialsUrl}"
                                            >
                                                ${msg("doForgotPassword")}
                                            </a>
                                        </span>
                                    </#if>
                                </div>  -->

                        </div>

                        <div class="mt-0">
                            <input
                                type="hidden"
                                id="id-hidden-input"
                                name="credentialId"
                                <#if auth.selectedCredential?has_content>
                                    value="${auth.selectedCredential}"
                                </#if>
                            />
                            <input
                                tabindex="7"
                                class="bg-emerald-500 self-stretch rounded-md h-10 w-full font-Jakarta text-sm font-medium text-white"
                                name="login"
                                id="kc-login"
                                type="submit"
                                value="${msg("doLogIn")}"
                            />
                        </div>
                    </form>
                    <div class="flex flex-col items-center justify-center w-full mt-4">
                        <a
                            tabindex="8"
                            class="no-underline hover:no-underline hover:text-black w-full bg-white rounded-md border border-gray-200 h-10 content-center text-center font-Jakarta text-sm font-medium"
                            href="${url.loginResetCredentialsUrl}"
                        >
                            ${msg("doForgotPassword")}
                        </a>
                    </div>
                    <hr class="h-px mt-4 bg-gray-200 border-0">
                </#if>
            </div>
            
            <script
                type="module"
                src="${url.resourcesPath}/js/passwordVisibility.js">
            </script>
        <#elseif section = "socialProviders" >
            <#if realm.password && social.providers??>
                <div id="kc-social-providers" >
                    <hr/>

                    <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                        <#list social.providers as p>
                            <li class="flex items-center justify-center font-Jakarta text-sm gap-5">
                                <span class="text-sm font-medium text-gray-500">
                                    ${msg("identity-provider-login-label")}
                                </span>
                                <a
                                    class="no-underline hover:no-underline"
                                    id="social-${p.alias}"
                                    <#if social.providers?size gt 3>
                                        ${properties.kcFormSocialAccountGridItem!}
                                    </#if>"
                                    type="button"
                                    href="${p.loginUrl}"
                                >
                                    <#if p.iconClasses?has_content>
                                        <div
                                            class="h-10 px-4 bg-white flex items-center justify-center rounded-lg border border-gray-200 gap-2">
                                            <img
                                                src="${url.resourcesPath}/img/google.svg"
                                                alt="google"
                                            >
                                            <span class="font-bold">
                                                ${p.displayName!}
                                            </span>
                                        </div>
                                    <#else>
                                        <span class="${properties.kcFormSocialAccountNameClass!}">
                                            ${p.displayName!}
                                        </span>
                                    </#if>
                                </a>
                            </li>
                        </#list>
                    </ul>
                </div>
            </#if>
            
        </#if>
    </@layout.registrationLayout>

    <div class="flex flex-col mt-8 items-center justify-center w-full">
        <a
            tabindex="8"
            class="no-underline hover:no-underline hover:text-black w-64 bg-white rounded-md h-10 content-center text-center font-Jakarta text-sm font-medium"
            href="${url.registrationUrl}"
        >
            ${msg("noAccount")}
        </a>
    </div>

</div>