<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "register-commons.ftl" as registerCommons>

<div class="flex flex-col h-screen items-center justify-center font-Jakarta font-semibold text-base">
        
    <@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
        <#if section = "header">
            <h1 class="text-xl font-semibold">${msg("registerTitle")}</h1>
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
                                            <h2>${msg("doRegisterWithGoogle")}</h2>
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

<div class="py-3 flex items-center text-xs uppercase before:flex-1 before:border-t before:border-gray-200 before:me-6 after:flex-1 after:border-t after:border-gray-200 after:ms-6 dark:before:border-gray-600 dark:after:border-gray-600">ou</div>
        
        <#elseif section = "form">
            <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">

                <@userProfileCommons.userProfileFormFields; callback, attribute>
                    <#if callback = "afterField">
                    <#-- render password fields just under the username or email (if used as username) -->
                        <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                            <div class="${properties.kcFormGroupClass!}">
                                <div class="${properties.kcLabelWrapperClass!}">
                                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label> *
                                </div>
                                <div class="${properties.kcInputWrapperClass!}">
                                    <div class="${properties.kcInputGroup!}">
                                        <input
                                            type="password"
                                            id="password"
                                            class="rounded-md border border-gray-200 bg-white py-2 px-3 h-9 w-full"
                                            autocomplete="new-password"
                                            aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                                        />
                                        <button class="${properties.kcFormPasswordVisibilityButtonClass!}" type="button" aria-label="${msg('showPassword')}"
                                                aria-controls="password"  data-password-toggle
                                                data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}" data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                                data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
                                            <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                                        </button>
                                    </div>

                                    <#if messagesPerField.existsError('password')>
                                        <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                        </span>
                                    </#if>
                                </div>
                            </div>

                            <div class="${properties.kcFormGroupClass!}">
                                <div class="${properties.kcLabelWrapperClass!}">
                                    <label for="password-confirm"
                                        class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label> *
                                </div>
                                <div class="${properties.kcInputWrapperClass!}">
                                    <div class="${properties.kcInputGroup!}">
                                        <input
                                            type="password"
                                            id="password-confirm"
                                            class="rounded-md border border-gray-200 bg-white py-2 px-3 h-9 w-full"
                                            name="password-confirm"
                                            aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                        />
                                        <button class="${properties.kcFormPasswordVisibilityButtonClass!}" type="button" aria-label="${msg('showPassword')}"
                                                aria-controls="password-confirm"  data-password-toggle
                                                data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}" data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                                data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
                                            <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                                        </button>
                                    </div>

                                    <#if messagesPerField.existsError('password-confirm')>
                                        <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                        </span>
                                    </#if>
                                </div>
                            </div>
                        </#if>
                    </#if>
                </@userProfileCommons.userProfileFormFields>

                <@registerCommons.termsAcceptance/>

                <#if recaptchaRequired??>
                    <div class="form-group">
                        <div class="${properties.kcInputWrapperClass!}">
                            <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                        </div>
                    </div>
                </#if>

                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                        </div>
                    </div>

                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                        <input
                            class="bg-emerald-500 self-stretch rounded-md h-10 w-full font-Jakarta text-sm font-medium text-white"
                            type="submit"
                            value="${msg("doRegister")}"
                            />
                    </div>
                </div>
            </form>
            <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
        </#if>
    </@layout.registrationLayout>
</div>
