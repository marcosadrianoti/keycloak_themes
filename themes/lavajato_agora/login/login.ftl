<#import "template.ftl" as layout>

<div class="flex flex-col h-screen items-center justify-center border border-orange-500">

    <@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
        <#if section = "header">
            <div class="flex flex-col">
                <img class="h-10 w-40" src="${url.resourcesPath}/img/logo.png" alt="logo">
                <span class="text-left mt-4 mb-4 font-Jakarta text-xl font-semibold">${msg("loginAccountTitle")}</span>
            </div>
            
        <#elseif section = "form">
            <div id="kc-form" >
            <div id="kc-form-wrapper" >
                <#if realm.password>
                    <form  id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <#if !usernameHidden??>
                            <div class="flex flex-col mb-4">
                                <label for="username" class="font-Jakarta font-medium text-sm">${msg("email")}</label>
                                <input tabindex="2" id="username"
                                    class="rounded-md border border-gray-200 bg-white py-2 px-3 h-9" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="username"
                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />

                                <#if messagesPerField.existsError('username','password')>
                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                    </span>
                                </#if>

                            </div>
                        </#if>
                        <div class="flex flex-col">
                            <label for="username" class="font-Jakarta font-medium text-sm">${msg("password")}</label>

                            <div class="${properties.kcInputGroup!}">
                                <input tabindex="3" id="password" class="rounded-md border border-gray-200 bg-white py-2 px-3 h-9" name="password" type="password" autocomplete="current-password"
                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />
                                <#--  <button class="${properties.kcFormPasswordVisibilityButtonClass!}" type="button" aria-label="${msg("showPassword")}"
                                        aria-controls="password" data-password-toggle tabindex="4"
                                        data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}" data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                        data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
                                    <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                                </button>  -->
                            </div>

                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite"
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
                                                <input tabindex="5" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                            <#else>
                                                <input tabindex="5" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                                </div>
                                <div class="${properties.kcFormOptionsWrapperClass!}">
                                    <#if realm.resetPasswordAllowed>
                                        <span class="font-bold"><a tabindex="6" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                    </#if>
                                </div>

                        </div>

                        <div class="mt-0">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="7"
                                class="mb-4 bg-emerald-500 self-stretch rounded-md h-10 w-full font-Jakarta text-sm font-medium text-white"
                                name="login"
                                id="kc-login"
                                type="submit"
                                value="${msg("doLogIn")}"
                            />
                        </div>
                    </form>
                    <hr class="h-px bg-gray-200 border-0">
                </#if>
                </div>
            </div>
            
            <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
        <#elseif section = "socialProviders" >
            <#if realm.password && social.providers??>
                <div id="kc-social-providers" >
                    <hr/>

                    <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                        <#list social.providers as p>
                            <li class="flex items-center justify-center font-Jakarta text-sm">
                                <a id="social-${p.alias}"  <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                        type="button" href="${p.loginUrl}">
                                    <#if p.iconClasses?has_content>
                                        <div class="flex items-center justify-center gap-5">
                                            <h2>${msg("identity-provider-login-label")}</h2>
                                            <div class="flex items-center justify-center gap-5">
                                                <img src="${url.resourcesPath}/img/google.svg" alt="google">
                                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text font-bold">${p.displayName!}</span>
                                            </div>
                                        </div>
                                    <#else>
                                        <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
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
            class="no-underline hover:no-underline hover:text-black w-64 bg-white rounded-md h-10 content-center text-center font-Jakarta text-sm font-medium" tabindex="8"
            href="${url.registrationUrl}"
        >
            ${msg("noAccount")}
        </a>
    </div>

</div>